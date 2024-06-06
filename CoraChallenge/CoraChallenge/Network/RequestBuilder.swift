import Foundation

public protocol RequestBuilding {
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest
}

public struct RequestBuilder: RequestBuilding {
    
    public init() {}
    
    public func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        let url = try buildURL(for: endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.value
        
        return request
    }
            
    private func buildURL(for endpoint: Endpoint) throws -> URL {
        var urlComponents = URLComponents(string: endpoint.baseURL)
        urlComponents?.path = endpoint.path
        
        let queryItems = endpoint.parameters?.map { item in
            URLQueryItem(
                name: item.key,
                value: item.value
            )
        }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw NetworkLayerError.unableToCreateURL
        }
        
        return url
    }
}
