import Foundation

final class ProfileImageService {

    static let shared = ProfileImageService()
    private var task: URLSessionTask?
    private (set) var avatarURL: String?
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")

    func fetchProfileImageURL(token: String,
                              username: String,
                              _ completion: @escaping (Result<String, Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        task?.cancel()
        let url = URLComponents(string: "\(Constans.unsplashProfileURLString)\(username)")!.url!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        task = session.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self = self else { return }
            do {
                let data = try result.get()
                let unwrappedAvatarURL = data.profileImage.small
                self.avatarURL = unwrappedAvatarURL
                completion(.success(unwrappedAvatarURL))
                NotificationCenter.default.post(name: ProfileImageService.DidChangeNotification,
                                                object: self,
                                                userInfo: ["URL": unwrappedAvatarURL])
                completion(.success(unwrappedAvatarURL))
            } catch let error {
                completion(.failure(error))
            }
        }
        task?.resume()
    }
}
