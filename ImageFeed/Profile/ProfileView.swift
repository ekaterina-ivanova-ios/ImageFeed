import UIKit

protocol ProfileViewDelegate: AnyObject {
    func logOutButtonTapped()
}

final class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profilePhoto") ?? UIImage())
        imageView.toAutolayout()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    private let profileLogOutButton: UIButton = {
        let button = UIButton.systemButton(with: UIImage(named: "ipad.and.arrow.forward") ?? UIImage(),
                                           target: nil, action: #selector(logOutTapped))
        button.toAutolayout()
        button.tintColor = .ypRed
        return button
    }()

    lazy var profileNameLabel = createLabel(withText: "Екатерина Новикова", textSize: 23, textColor: .ypWhite)
    lazy var accountNameLabel = createLabel(withText: "@ekaterina_nov", textSize: 13, textColor: .ypGray)
    lazy var profileInfoLabel = createLabel(withText: "Hello, world!", textSize: 13, textColor: .ypWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func logOutTapped() {
        delegate?.logOutButtonTapped()
    }

    private func createLabel(withText text: String, textSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.toAutolayout()
        label.text = text
        label.font = UIFont(name: "YSDisplay-Medium", size: textSize)
        label.textColor = textColor
        return label
    }

    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(profileLogOutButton)
        addSubview(profileNameLabel)
        addSubview(accountNameLabel)
        addSubview(profileInfoLabel)
    }

    private func setupConstraints() {
        let constraints = [
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 76),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileLogOutButton.widthAnchor.constraint(equalToConstant: 20),
            profileLogOutButton.heightAnchor.constraint(equalToConstant: 22),
            profileLogOutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileLogOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            profileNameLabel.heightAnchor.constraint(equalToConstant: 18),
            profileNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            profileNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            accountNameLabel.heightAnchor.constraint(equalToConstant: 18),
            accountNameLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 8),
            accountNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileInfoLabel.heightAnchor.constraint(equalToConstant: 18),
            profileInfoLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 8),
            profileInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
import Foundation
