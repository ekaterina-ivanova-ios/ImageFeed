import UIKit
import Kingfisher
import SwiftKeychainWrapper

final class ProfileViewController: UIViewController {

    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?

    lazy var profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
        view.addSubview(profileView)
        setupConstraints()
        configureKFCache()
        updateProfileDetails(profile: profileService.profile)
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.DidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        updateAvatar()
    }

    private func setupConstraints() {
        let constraints = [
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else { return }
        profileView.profileNameLabel.text = profile.name
        profileView.accountNameLabel.text = profile.loginName
        profileView.profileInfoLabel.text = profile.bio == "" ? "Account info was not provided" : profile.bio
    }

    private func updateAvatar() {
        guard let profileImageURL = ProfileImageService.shared.avatarURL,
              let url = URL(string: profileImageURL)
        else { return }
        loadImageWithKFTo(imageView: profileView.profileImageView, usingURL: url)
    }

    private func configureKFCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.countLimit = 10
        cache.diskStorage.config.sizeLimit = 1000 * 1000 * 50
        cache.diskStorage.config.expiration = .never
        cache.memoryStorage.config.cleanInterval = 86400
    }

    private func loadImageWithKFTo(imageView: UIImageView, usingURL url: URL) {
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder.jpeg"))
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func logOutButtonTapped() {
        print(#function)
        KeychainWrapper.standard.removeObject(forKey: "bearerToken")
    }
}

