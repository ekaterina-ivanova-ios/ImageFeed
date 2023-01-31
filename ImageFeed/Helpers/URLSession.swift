import Foundation

extension URLSession {

    func objectTask<T: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionTask {
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.codeError))
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.dataError))
                return
            }
        })
        return task
    }
}
