import Foundation

final class ProfileImageService {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private(set) var avatarURL: String?
    
    private func makeRequest(_ token: String, username: String) -> URLRequest {
        guard let url = URL(string: Constants.unsplashGetProfileImage + username) else { return URLRequest(url: URL(fileURLWithPath: "")) }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func fetchProfileImageURL(_ token: String, username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        let request = makeRequest(token, username: username)
        let session = urlSession
        let task = session.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.avatarURL = image.profileImage?.small
                completion(.success(self.avatarURL ?? ""))
                NotificationCenter.default
                    .post(
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": self.avatarURL ?? ""]
                    )
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        
        self.task = task
        task.resume()
    }
}
