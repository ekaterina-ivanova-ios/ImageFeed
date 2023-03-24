import Foundation

protocol WebViewHelperProtocol {
    func cleanCookies()
}

final class WebViewHelper: WebViewHelperProtocol {
    func cleanCookies() {
        WebViewViewController.clean()
    }
}
