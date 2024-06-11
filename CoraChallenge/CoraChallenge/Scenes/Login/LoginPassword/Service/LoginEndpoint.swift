import Foundation

enum LoginEndpoint: Endpoint {
    case login(
        cpf: String,
        password: String
    )
    
    var path: String { "/challenge/auth" }
    
    var urlParameters: [String : String]? { nil}
    
    var bodyParameters: [String : String]? {
        switch self {
        case let .login(cpf, password):
            return  [
                "cpf": cpf,
                "password": password
            ]
        }
    }
    
    var headerParameters: [String: String]? { nil }
    
    var method: HTTPMethod { .post }
}
