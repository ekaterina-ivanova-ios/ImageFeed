import Foundation

enum Constants {
    static let accessKey = "PynczGdfM1b5gJokKViG1hqfVPZFqH5lmKsYBF-VoZY"
    static let secretKey = "kjJylFBGKr5bYPs_1QBuat2PA-LedB-7zSgtCqkTroM"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let unsplashAuthorizeTokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashGetProfile = "https://api.unsplash.com/me"
    static let unsplashGetProfileImage = "https://api.unsplash.com/users/"
    static let unsplashGetListPhotos = "https://api.unsplash.com/photos"
}
