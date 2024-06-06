import Foundation

enum LoginPasswordModels {
    
    struct LoginParameters: LoginParametersProtocol {
        let cpf: String
        let password: String
    }
    
    struct Actions: LoginPasswordActions {
        let didTapNextButton: (String?) -> Void
    }
    
}
