import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonSetting()
    }
    
    func commonSetting() {
        //MARK: settingImageProfile
        let profileImage = UIImage(named: "Photo")
        let ImageProfile = UIImageView(image: profileImage)
        view.addSubview(ImageProfile)
        ImageProfile.translatesAutoresizingMaskIntoConstraints = false
        ImageProfile.widthAnchor.constraint(equalToConstant: 70).isActive = true
        ImageProfile.heightAnchor.constraint(equalToConstant: 70).isActive = true
        ImageProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 76).isActive = true
        ImageProfile.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        //MARK: settingUserNameLabel
        let UserNameLabel = UILabel()
        UserNameLabel.text = "Екатерина Новикова"
        UserNameLabel.textColor = .white
        UserNameLabel.font = UserNameLabel.font.withSize(23)
        view.addSubview(UserNameLabel)
        UserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        UserNameLabel.topAnchor.constraint(equalTo: ImageProfile.bottomAnchor, constant: 8).isActive = true
        UserNameLabel.leadingAnchor.constraint(equalTo: ImageProfile.leadingAnchor).isActive = true
        
        //MARK: settingUserIdLabel
        let UserIdLabel = UILabel()
        UserIdLabel.text = "@ekaterina_nov"
        UserIdLabel.textColor = .gray
        UserIdLabel.font = UserNameLabel.font.withSize(13)
        view.addSubview(UserIdLabel)
        UserIdLabel.translatesAutoresizingMaskIntoConstraints = false
        UserIdLabel.topAnchor.constraint(equalTo: UserNameLabel.bottomAnchor, constant: 8).isActive = true
        UserIdLabel.leadingAnchor.constraint(equalTo: UserNameLabel.leadingAnchor).isActive = true
        
        //MARK: settingInfoLabel
        let InfoLabel = UILabel()
        InfoLabel.text = "Hello, world!"
        InfoLabel.textColor = .white
        InfoLabel.font = UserNameLabel.font.withSize(13)
        view.addSubview(InfoLabel)
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.topAnchor.constraint(equalTo: UserIdLabel.bottomAnchor, constant: 8).isActive = true
        InfoLabel.leadingAnchor.constraint(equalTo: UserIdLabel.leadingAnchor).isActive = true
        
        //MARK: settingLogOutButton
        let logOutButton = UIButton.systemButton(
            with: UIImage(named: "logOut")!,
            target: self,
            action: #selector(Self.tapLogOutButton)
            )
        logOutButton.tintColor = .systemRed
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }

    @objc
    private func tapLogOutButton(_ sender: Any) {
        exit(1)
        }
    
    
}
