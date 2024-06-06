import Foundation

public protocol URLSessioning {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<(Data, URLResponse), NetworkLayerError>) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessioning {
    public func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<(Data, URLResponse), NetworkLayerError>) -> Void
    ) -> URLSessionDataTask {
        return dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(NetworkLayerError.transportError(error)))
                return
            }
            
            guard let response = response else {
                completionHandler(.failure(NetworkLayerError.noResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkLayerError.noData))
                return
            }
            
            completionHandler(.success((data, response)))

        }
    }
}
