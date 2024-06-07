import Foundation

enum StatementModels {
    
    struct Action: StatementViewActions {
        let didPullToRefresh: () -> Void
    }
    
}
