import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
}

final class AuthHelper: AuthHelperProtocol {
    //MARK: - Properties
    let authConfiguration: AuthConfiguration
    
    //MARK: - LifeCycle
    init(authConfiguration: AuthConfiguration = .standard) {
        self.authConfiguration = authConfiguration
    }
    
    //MARK: - Functions
    func authRequest() -> URLRequest? {
        guard let url = authURL() else { return nil }
        return URLRequest(url: url)
    }
    
    func authURL() -> URL? {
        if var urlComponents = URLComponents(
            string: authConfiguration.unsplashAuthorizeURLString
        ) {
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: authConfiguration.accessKey),
                URLQueryItem(name: "redirect_uri", value: authConfiguration.redirectURI),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: authConfiguration.accessScope)
            ]
            guard let url = urlComponents.url else { return nil }
            return url
        } else {
            return nil
        }
        
    }
    
    func code(from url: URL) -> String? {
        if
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
