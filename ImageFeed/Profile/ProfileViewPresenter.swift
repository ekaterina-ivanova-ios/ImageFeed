import Foundation

protocol ProfileViewPresenterProtocol {
    func getProfile() -> Profile?
    func getUrlAvatar() -> URL?
    func logout()
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    //MARK: - Properties
    private let profileService: ProfileService
    private let profileImageService: ProfileImageService
    private let oAuth2TokenStorage: OAuth2TokenStorage
    private let helper: WebViewHelperProtocol
    
    weak var view: ProfileViewControllerProtocol?
    
    //MARK: - LifeCycle
    init(
        viewController: ProfileViewControllerProtocol,
        profileService: ProfileService = .shared,
        profileImageService: ProfileImageService = .shared,
        oAuth2TokenStorage: OAuth2TokenStorage = OAuth2TokenStorage(),
        helper: WebViewHelperProtocol = WebViewHelper()
    ) {
        self.profileService = profileService
        self.profileImageService = profileImageService
        self.oAuth2TokenStorage = oAuth2TokenStorage
        self.helper = helper
    }
    
    //MARK: - Functions
    func getProfile() -> Profile? {
        let profile = profileService.profile
        return profile
    }
    
    func getUrlAvatar() -> URL? {
        let imageUrl = profileImageService.avatarURL ?? ""
        let url = URL(string: imageUrl)
        return url
    }
    
    func logout() {
        oAuth2TokenStorage.bearerToken = nil
        helper.cleanCookies()
    }
}
