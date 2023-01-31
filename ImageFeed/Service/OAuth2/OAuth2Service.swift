import Foundation

final class OAuth2Service {
    private let urlSession = URLSession.shared //1
    private var task: URLSessionTask?     //2
    private var lastCode: String?   //3
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
                task?.cancel()
                lastCode = code
        
        let request = makeRequest(code: code)
        let task = urlSession.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        completion(.success("")) // TODO [Sprint 10]
                        self.task = nil
                        if error != nil {
                            self.lastCode = nil
                        }
                    }
                }
                self.task = task
                task.resume()
    }
    
    private func makeRequest(code: String) -> URLRequest {
            guard let url = URL(string: "...\(code)") else { fatalError("Failed to create URL") }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
    
}
