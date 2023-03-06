
import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage?
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "Photo"
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}
