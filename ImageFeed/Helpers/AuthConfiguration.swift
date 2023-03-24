import Foundation

let baseAccessKey = "PynczGdfM1b5gJokKViG1hqfVPZFqH5lmKsYBF-VoZY"
let baseSecretKey = "kjJylFBGKr5bYPs_1QBuat2PA-LedB-7zSgtCqkTroM"
let baseRedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let baseAccessScope = "public+read_user+write_likes"

let baseDefaultBaseURL = URL(string: "https://api.unsplash.com")
let baseUnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let baseUnsplashAuthorizeTokenURLString = "https://unsplash.com/oauth/token"
let baseUnsplashGetProfile = "https://api.unsplash.com/me"
let baseUnsplashGetProfileImage = "https://api.unsplash.com/users/"
let baseUnsplashGetListPhotos = "https://api.unsplash.com/photos"


struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let unsplashAuthorizeURLString: String
    let unsplashAuthorizeTokenURLString: String
    let unsplashGetProfile: String
    let unsplashGetProfileImage: String
    let unsplashGetListPhotos: String
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(
            accessKey: baseAccessKey,
            secretKey: baseSecretKey,
            redirectURI: baseRedirectURI,
            accessScope: baseAccessScope,
            defaultBaseURL: baseDefaultBaseURL ?? URL(fileURLWithPath: ""),
            unsplashAuthorizeURLString: baseUnsplashAuthorizeURLString,
            unsplashAuthorizeTokenURLString: baseUnsplashAuthorizeTokenURLString,
            unsplashGetProfile: baseUnsplashGetProfile,
            unsplashGetProfileImage: baseUnsplashGetProfileImage,
            unsplashGetListPhotos: baseUnsplashGetListPhotos
        )
    }
}
