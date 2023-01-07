import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setUpBackButton()
        
    }
 
    func setUpWebView() {
        let webView = WKWebView()
        webView.backgroundColor = .ypWhite
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setUpBackButton() {
        let button = UIButton.systemButton(
            with: UIImage(named: "nav_back_button_white")!,
            target: self,
            action: #selector(Self.tappedButton)
            )
        button.tintColor = .ypBlack
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 59).isActive = true

    }
    
    @objc
    func tappedButton() {
        
    }
    
}
