import Foundation

enum StatementDetailsModels {
    
    enum SceneErrors: Error {
        case tokenIsNil
    }
    
    enum DidLoad {
        enum Response {
            struct Success {
                let decodable: StatementDetailsResponse
            }
            
            struct Failure {
                let error: Error
            }
        }
        
        enum ViewModel {
            struct Success {}
            
            struct Failure {
                let error: Error
            }
        }
        
    }
    
}
