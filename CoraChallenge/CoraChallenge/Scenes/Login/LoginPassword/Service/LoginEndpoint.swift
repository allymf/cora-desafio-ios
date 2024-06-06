import Foundation

enum LoginEndpoint: Endpoint {
    case login(
        cpf: String,
        password: String
    )
    
    var baseURL: String { "https://api.challenge.stage.cora.com.br" }
    
    var path: String { "challenge/auth" }
    
    var parameters: [String : String]? {
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
