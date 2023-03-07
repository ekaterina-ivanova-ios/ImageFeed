import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    //MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.config(
            for: label,
            text: "Екатерина Новикова",
            fontSize: 23,
            textColor: .ypWhite)
        return label
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.config(
            for: label,
            text: "@ekaterina_nov",
            fontSize: 13,
            textColor: .ypGray)
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.config(
            for: label,
            text: "Hello, world!",
            fontSize: 13,
            textColor: .ypWhite)
        return label
    }()
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "logOut"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage()

    private var profileImageServiceObserver: NSObjectProtocol?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileInfo(profileService.profile ?? Profile(
            username: "",
            name: "",
            loginName: "",
            bio: ""
        ))
        view.backgroundColor = .ypBlack
        addSubviews()
        setupConstraints()
        profileImageServiceObserver = NotificationCenter.default
                    .addObserver(
                        forName: ProfileImageService.didChangeNotification,
                        object: nil,
                        queue: .main
                    ) { [weak self] _ in
                        guard let self = self else { return }
                        self.updateAvatar()
                    }
        updateAvatar()
    }
    
    //MARK: - Helpers
    private func addSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(statusLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupProfileInfo(_ profile: Profile) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.nameLabel.text = profile.name
            self.usernameLabel.text = profile.loginName
            self.statusLabel.text = profile.bio
        }
    }
    
    private func updateAvatar() {
        if let profileImageURL = profileImageService.avatarURL,
           let url = URL(string: profileImageURL) {

            let cache = ImageCache.default
            cache.clearMemoryCache()
            cache.clearDiskCache()

            let processor = RoundCornerImageProcessor(cornerRadius: (profileImageView.image?.size.width ?? 0) / 2)
            self.profileImageView.kf.indicatorType = .activity
            self.profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "person.crop.circle.fill"),
                options: [.processor(processor)]
            ) { result in
                switch result {
                case .success(let value):
                    print("Аватарка \(value.image) была успешно загружена и заменена в профиле")
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            profileImageView.image = UIImage(named: "person.crop.circle.fill")
        }
    }
    
    private func logoutFromProfile() {
        oAuth2TokenStorage.bearerToken = nil
        WebViewViewController.clean()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let authViewController = storyboard.instantiateViewController(
            withIdentifier: "AuthViewController"
        ) as? AuthViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }

    @objc private func didTapButton() {
        showDoubleAlert(
            title: "До встречи!",
            message: "Уверены, что хотите выйти?",
            firstAction: "Да",
            secondAction: "Нет"
        ) { [weak self] _ in
            guard let self = self else { return }
            self.logoutFromProfile()
        } _: { _ in }
    }
    
}
