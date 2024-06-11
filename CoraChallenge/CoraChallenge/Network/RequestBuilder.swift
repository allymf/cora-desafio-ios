import Foundation

public protocol RequestBuilding {
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest
}

public protocol JSONSerializing {
    static func data(from dictionary: [String: String]) throws -> Data
    
}
extension JSONSerialization: JSONSerializing {
    public static func data(from dictionary: [String: String]) throws -> Data {
        try data(withJSONObject: dictionary)
    }
}

public struct RequestBuilder: RequestBuilding {
    
    enum RequestBuilderErrors: Error {
        case baseURLNil
    }
    
    private let infoDictionary: [String: Any]?
    
    private var apiKey: String? {
        infoDictionary?["API_KEY"] as? String
    }
    
    private var baseURL: String? {
        infoDictionary?["API_BASE_URL"] as? String
    }
    
    public init(infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        self.infoDictionary = infoDictionary
    }
    
    public func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        let url = try buildURL(for: endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.value
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        setupHeaderField(
            in: &request,
            for: endpoint
        )
        
        request.httpBody = makeBodyParameters(for: endpoint)
        
        return request
    }
    
    private func buildURL(for endpoint: Endpoint) throws -> URL {
        guard let baseURL else {
            throw RequestBuilderErrors.baseURLNil
        }
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = endpoint.path
        
        urlComponents?.queryItems = makeQueryItems(from: endpoint.urlParameters)
        
        guard let url = urlComponents?.url else {
            throw NetworkLayerError.unableToCreateURL
        }
        
        return url
    }
    
    private func makeQueryItems(from dictionary: [String: String]?) -> [URLQueryItem]? {
        return dictionary?.map { item in
            URLQueryItem(
                name: item.key,
                value: item.value
            )
        }
    }
    
    private func makeBodyParameters(for endpoint: Endpoint) -> Data? {
        let urlQueryItems = makeQueryItems(from: endpoint.bodyParameters)
        
        var urlComponents = URLComponents(string: String())
        urlComponents?.queryItems = urlQueryItems
        
        return urlComponents?.query?.data(using: .utf8)
    }
    
    private func setupHeaderField(in request: inout URLRequest, for endpoint: Endpoint) {
        endpoint.headerParameters?.forEach { item in
            request.setValue(
                item.value,
                forHTTPHeaderField: item.key
            )
        }
    }
    
}
