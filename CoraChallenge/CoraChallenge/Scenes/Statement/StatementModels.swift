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
            
            struct Success {
                let sceneViewModel: StatementViewModel
            }
            
            struct Failure {
                let error: Error
            }
            
        }
        
    }
    
    struct StatementViewModel {
        struct Section {
            let title: String
            let date: Date
            let items: [Item]
        }
        
        struct Item {
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
