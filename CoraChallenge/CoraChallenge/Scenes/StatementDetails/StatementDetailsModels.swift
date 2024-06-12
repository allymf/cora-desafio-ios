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
            struct Success {
                let sceneViewModel: StatementDetailViewModel
            }
            
            struct Failure {
                let error: Error
            }
        }
        
    }
    
    enum DocumentType: String {
        case cpf, cnpj, none
    }
    
    struct StatementDetailViewModel: Equatable {
        struct ActorViewModel: Equatable {
            let name: String
            let document: String
            let bankName: String
            let accountInformation: String
        }
        let title: String
        let value: String
        let dateText: String
        let senderViewModel: ActorViewModel
        let receiverViewModel: ActorViewModel
        let description: String
    }
    
}
