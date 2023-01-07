import UIKit

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLogo()
        settingButton()
    }
    
    func settingLogo() {
        let screenImage = UIImage(named: "Vector")
        let logoImage = UIImageView(image: screenImage)
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func settingButton() {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.ypBlack, for: .normal)
        button.backgroundColor = .ypWhite
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -124).isActive = true
        
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
     @objc
     func tappedButton() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         guard let newScreen = storyboard.instantiateViewController(identifier: "WebViewViewController") as? WebViewViewController else {return}
         
         show(newScreen, sender: nil)
         
     }
    
}
