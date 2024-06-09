import Foundation

enum LoginCPFModels {
    
    struct Actions: LoginCPFViewActions {
        let didTapNextButton: (String?) -> Void
        let cpfTextDidChange: (String?) -> Void
    }
    
    enum ValidateCPF {
        struct Request {
            let cpfText: String?
        }
    }
    
    enum NextButton {
        enum Response {
            struct Failure {
                let error: SceneError
            }
        }
        
        enum ViewModel {
            struct Failure {
                let error: SceneError
            }
        }
    }
    
    enum SceneError: Error {
        case CPFIsEmpty
    }
    
}
