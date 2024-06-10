import Foundation

enum StatementModels {
    
    enum LoadStatement {
        
        enum Response {
            
            struct Success {
                let response: StatementResponse
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
    
    struct Action: StatementViewActions {
        let didPullToRefresh: () -> Void
    }
    
}
