import Foundation

final class ProfileService {

    static let shared = ProfileService()
    private var task: URLSessionTask?
    private(set) var profile: Profile?

    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        let url = URLComponents(string: Constans.unsplashUserURLString)!.url!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        task = session.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            do {
                let data = try result.get()
                let unwrappedProfile = Profile(username: data.username,
                                               name: "\(data.firstName) \(data.lastName)",
                                               loginName: "@\(data.username)",
                                               bio: data.bio ?? "")
                self.profile = unwrappedProfile
                completion(.success(unwrappedProfile))
            } catch let error {
                completion(.failure(error))
            }
        }
        task?.resume()
    }
}
