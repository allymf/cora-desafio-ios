import Foundation

enum LoginCPFModels {
    
    struct Actions: LoginCPFViewActions {
        let didTapNextButton: (String?) -> Void
    }
    
    struct Request {
        let cpfText: String?
    }
    
    enum Response {
        struct Success {}
        struct Failure {
            let error: SceneError
        }
    }
    
    enum ViewModel {
        struct Success {}
        struct Failure {
            let error: SceneError
        }
    }
    
    enum SceneError: Error {
        case CPFIsEmpty
    }
    
}
