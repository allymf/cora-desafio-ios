import Foundation

enum LoginPasswordModels {
    
    struct Actions: LoginPasswordActions {
        let didTapNextButton: (String?) -> Void
    }
    
}
