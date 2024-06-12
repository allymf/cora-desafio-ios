import Foundation

enum StatementDetailsEndpoint: Endpoint {
    case statementItemDetails(id: String, token: String)
    
    var path: String {
        switch self {
        case let .statementItemDetails(id, _):
            "/challenge/details/" + id
        }
    }
    
    var urlParameters: [String : String]? { nil }
    
    var bodyParameters: [String : String]? { nil }
    
    var headerParameters: [String : String]? {
        switch self {
        case let .statementItemDetails(_, token):
            ["token": token]
        }
    }
    
    var method: HTTPMethod { .get }
    
    
}
