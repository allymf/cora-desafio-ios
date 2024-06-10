import Foundation

enum LoginPasswordModels {
    
    enum NextButton {
        struct Request {
            let password: String?
        }
    }
    
    struct LoginParameters: LoginParametersProtocol {
        let cpf: String
        let password: String
    }
    
    struct Actions: LoginPasswordActions {
        let didTapNextButton: (String?) -> Void
    }
    
}
