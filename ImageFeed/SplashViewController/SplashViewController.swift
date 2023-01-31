import UIKit

final class SplashViewController: UIViewController {
    private let profileService = ProfileService.shared
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"

    private let oauth2Service = OAuth2Service()
    private let oauth2TokenStorage = OAuth2TokenStorage()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if oauth2TokenStorage.token != nil {switchToTabBarController()} else {performSegue(withIdentifier: ShowAuthenticationScreenSegueIdentifier, sender: nil)}
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                UIBlockingProgressHUD.show()
                self.fetchOAuthToken(code)
            }
        }
           
           private func fetchOAuthToken(_ code: String) {
            oauth2Service.fetchOAuthToken(code) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    self.fetchProfile(token: token)
                case .failure:
                    UIBlockingProgressHUD.dismiss()
                    // TODO [Sprint 11] Показать ошибку
                    break
                }
            }
        }

    private func fetchProfile(token: String) {
        profileService.fetchProfile(oauth2TokenStorage.token ?? "") { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    UIBlockingProgressHUD.dismiss()
                    self.switchToTabBarController()
                case .failure:
                    UIBlockingProgressHUD.dismiss()
                    let errorAlert = UIAlertController()
                        .createSimpleAlert(withTitle: "Что-то пошло не так(",
                                           message: "Не удалось войти в систему",
                                           andButtonTitle: "Ок")
                    self.present(errorAlert, animated: true)
                    break
                }
            }
        }
    }
}
