import Foundation

enum LoginPasswordModels {
    
    enum NextButton {
        struct Request {
            let password: String?
        }
        
        enum Response {
            struct Failure {
                let error: Error
            }
        }
        
        enum ViewModel {
            struct Failure {
                let error: Error
            }
        }
    }
    
    enum SceneErrors: Error {
        case passwordIsNil
        case tokenIsNil
        case unableToStoreToken
        
    }
    
    struct LoginParameters: LoginParametersProtocol {
        let cpf: String
        let password: String
    }
    
    struct Actions: LoginPasswordActions {
        let didTapNextButton: (String?) -> Void
    }
    
}
