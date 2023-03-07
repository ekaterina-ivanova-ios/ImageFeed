
import Foundation

struct PhotoResult: Codable {
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let description: String?
    let likedByUser: Bool
    let urls: UrlsResult?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case description
        case likedByUser = "liked_by_user"
        case urls
    }
    
    func convert() -> Photo {
        return Photo(
            id: self.id,
            size: CGSize(width: self.width, height: self.height),
            createdAt: Date().convertStringToDate(self.createdAt ?? ""),
            welcomeDescription: self.description ?? "",
            thumbImageURL: self.urls?.thumb ?? "",
            largeImageURL: self.urls?.full ?? "",
            isLiked: self.likedByUser
        )
    }
}

struct UrlsResult: Codable {
    let full: String?
    let thumb: String?
}

struct PhotoLikeResult: Codable {}
