import Foundation

private enum NetworkError: Error {
    case codeError
}

extension URLSession {
    func objectTask<T: Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 200 && response.statusCode < 300 {
                    if let data = data {
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(result))
                        } catch let error {
                            completion(.failure(error))
                        }
                    }
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.codeError))
                }
            }
        })
        return task
    }
}
