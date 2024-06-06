import Foundation

public enum NetworkLayerError: Error {
    case unableToCreateURL
    case unableToCreateRequest
    case unableToDecodeResponse(decodingError: DecodingError)
    case transportError(Error)
    case noData
    case noResponse
    case invalidResponseType
    case serverSideError(statusCode: Int)
    case unknownError(Error)
}

public protocol HTTPClient {
    func request<Response: Decodable>(
        endpoint: Endpoint,
        responseType: Response.Type,
        completionHandler: @escaping (Result<Response, NetworkLayerError>) -> Void
    )
    
    func cancelCurrentTask()
}

public final class NetworkService: HTTPClient {
    
    private let requestBuilder: RequestBuilding
    private let session: URLSessioning
    private let decoder: Decoding
    private var task: URLSessionDataTask?
    
    public init(
        requestBuilder: RequestBuilding = RequestBuilder(),
        session: URLSessioning = URLSession.shared,
        decoder: Decoding = JSONDecoder()
    ) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.decoder = decoder
    }
    
    public func request<Response: Decodable>(
        endpoint: Endpoint,
        responseType: Response.Type,
        completionHandler: @escaping (Result<Response, NetworkLayerError>) -> Void
    ) {
        do {
            let request = try requestBuilder.buildRequest(for: endpoint)
            
            task = session.dataTask(with: request) { response in
                let result = self.handleRequestResponse(response)
                
                switch result {
                case let .failure(error):
                    completionHandler(.failure(error))
                    
                case let .success(data):
                    do {
                        let response = try self.decoder.decode(
                            responseType,
                            from: data
                        )
                        completionHandler(.success(response))
                    } catch let decodingError as DecodingError {
                        completionHandler(.failure(NetworkLayerError.unableToDecodeResponse(decodingError: decodingError)))
                    } catch {
                        completionHandler(.failure(NetworkLayerError.unknownError(error)))
                    }
                    
                }
            }
            
            task?.resume()
            
        } catch let error as NetworkLayerError {
            completionHandler(.failure(error))
        } catch {
            completionHandler(.failure(NetworkLayerError.unknownError(error)))
        }
        
    }
    
    public func cancelCurrentTask() {
        task?.cancel()
    }
    
    private func handleRequestResponse(_ response: Result<(Data, URLResponse), NetworkLayerError>) -> Result<Data, NetworkLayerError> {
        switch response {
        case let .failure(error):
            return .failure(error)
        case let .success((data, response)):
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkLayerError.invalidResponseType)
            }
            
            return handleHTTPRequestResponse(httpResponse, data: data)
        }
    }
    
    private func handleHTTPRequestResponse(_ response: HTTPURLResponse, data: Data) -> Result<Data, NetworkLayerError> {
        switch response.statusCode {
        case 200...299:
            return .success(data)
        default:
            return .failure(NetworkLayerError.serverSideError(statusCode: response.statusCode))
        }
    }
    
}
