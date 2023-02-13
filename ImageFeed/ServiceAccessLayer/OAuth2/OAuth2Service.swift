
import Foundation

protocol OAuth2ServiceProtocol {
    func fetchAuthToken(_ code: String, _ completion: @escaping (Result<String, Error>) -> Void)
}

private enum NetworkError: Error {
    case codeError
}

final class OAuth2Service: OAuth2ServiceProtocol {
    
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private var lastCode: String?
    
    private func makeRequest(code: String) -> URLRequest {
        guard var urlComponents = URLComponents(string: Constants.unsplashAuthorizeTokenURLString) else { return URLRequest(url: URL(fileURLWithPath: "")) }
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        guard let url = urlComponents.url else { fatalError("Failed to create URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchAuthToken(_ code: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        
        let request = makeRequest(code: code)
        let session = urlSession
        let task = session.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let responseBody):
                completion(.success(responseBody.accessToken))
            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}

