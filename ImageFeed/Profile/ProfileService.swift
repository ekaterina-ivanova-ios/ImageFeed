import Foundation

protocol ProfileServiceProtocol {
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
    static let shared = ProfileService()
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private(set) var profile: Profile?
    
    private let authConfiguration = AuthConfiguration.standard
    
    private func convertFrom(profileResult: ProfileResult) -> Profile {
        let username = "\(profileResult.username ?? "")"
        let name = "\(profileResult.firstName ?? "") \(profileResult.lastName ?? "")"
        let loginName = "@\(profileResult.username ?? "")"
        let bio = "\(profileResult.bio ?? "")"
        
        return Profile(username: username, name: name, loginName: loginName, bio: bio)
    }
    
    private func makeRequest(_ token: String) -> URLRequest {
        guard let url = URL(string: authConfiguration.unsplashGetProfile) else { return URLRequest(url: URL(fileURLWithPath: "")) }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        let request = makeRequest(token)
        let session = urlSession
        let task = session.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let profileResult):
                let currentProfile = self.convertFrom(profileResult: profileResult)
                self.profile = currentProfile
                completion(.success(self.profile ?? Profile(
                    username: "failure",
                    name: "failure",
                    loginName: "failure",
                    bio: "failure"
                )))
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}
