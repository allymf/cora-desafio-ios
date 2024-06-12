import Foundation

enum StatementModels {
    
    enum SceneErrors: Error {
        case itemUnavailable
    }
    
    enum LoadStatement {
        
        enum Response {
            struct Success: Equatable {
                let response: StatementResponse
            }
            
            struct Failure {
                let error: Error
            }
        }
        
        enum ViewModel {
            struct Success: Equatable {
                let sceneViewModel: StatementViewModel
            }
            
            struct Failure {
                let error: Error
            }
        }
        
    }
    
    enum SelectItem {
        
        struct Request {
            let indexPath: IndexPath
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
    
    struct StatementViewModel: Equatable {
        struct Section: Equatable {
            let title: String
            let date: Date
            let items: [Item]
        }
        
        struct Item: Equatable {
            let description: String
            let label: String
            let entry: Entry
            let currencyAmount: String
            let name: String
            let hourText: String
            let status: Status
        }
        
        enum Entry: String {
            case debit
            case credit
            case none
        }
        
        enum Status: String {
            case completed
            case none
        }
        
        let sections: [Section]
    }
    
    struct Action: StatementViewActions {
        let didPullToRefresh: () -> Void
    }
    
}
