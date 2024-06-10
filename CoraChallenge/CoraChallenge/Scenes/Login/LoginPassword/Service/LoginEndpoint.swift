import Foundation

enum LoginEndpoint: Endpoint {
    case login(
        cpf: String,
        password: String
    )
    
    var path: String { "/challenge/auth" }
    
    var urlParameters: [String : String]? { return nil}
    
    var bodyParameters: [String : String]? {
        switch self {
        case let .login(cpf, password):
            return  [
                "cpf": cpf,
                "password": password
            ]
        }
    }
    
    var method: HTTPMethod { .post }
}
