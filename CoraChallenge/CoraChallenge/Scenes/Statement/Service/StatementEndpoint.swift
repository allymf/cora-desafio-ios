import Foundation

enum StatementEndpoint: Endpoint {
    
    case statement(token: String)
    
    var path: String { "challenge/list" }
    
    var urlParameters: [String : String]? { nil }
    
    var bodyParameters: [String : String]? { nil }
    
    var headerParameters: [String: String]? {
        switch self {
        case let .statement(token):
            return ["token": token]
        }
    }
    
    var method: HTTPMethod { .get }
    
}
