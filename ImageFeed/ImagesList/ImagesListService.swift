import Foundation

final class ImagesListService {
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private let token = OAuth2TokenStorage().bearerToken
    
    private let authConfiguration = AuthConfiguration.standard
    
    func fetchPhotosNextPage() {
        if task != nil { return }
        
        let nextPage: Int
        if let lastLoadedPage {
            nextPage = lastLoadedPage + 1
        } else {
            nextPage = 1
        }
        
        guard var urlComponents = URLComponents(string: authConfiguration.unsplashGetListPhotos) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(nextPage)")
        ]
        
        guard let url = urlComponents.url,
              let token = token
        else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = urlSession
        session.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let responsePhotos):
                    self.lastLoadedPage = nextPage
                    let currentPhotos = responsePhotos.map { $0.convert() }
                    self.photos.append(contentsOf: currentPhotos)
                    NotificationCenter.default.post(
                        name: ImagesListService.didChangeNotification,
                        object: self
                    )
                case .failure(let error):
                    print(error)
                }
            }
            self.task = nil
        }.resume()
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        if task != nil { return }
        
        guard let url = URL(string: "\(authConfiguration.unsplashGetListPhotos)/\(photoId)/like"),
              let token = token
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = isLike ? "POST" : "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = urlSession
        session.objectTask(for: request) { [weak self] (result: Result<PhotoLikeResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                guard let index = self.photos.firstIndex(where: { $0.id == photoId }) else { return }
                let photo = self.photos[index]
                self.photos[index].isLiked = !photo.isLiked
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }.resume()
    }
}
