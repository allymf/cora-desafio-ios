import Foundation

struct StatementDetailsResponse: Decodable, Equatable {
    
    struct Actor: Decodable, Equatable {
        let bankName: String?
        let bankNumber: String?
        let documentNumber: String?
        let documentType: String?
        let accountNumberDigit: String?
        let agencyNumberDigit: String?
        let agencyNumber: String?
        let name: String?
        let accountNumber: String?
    }
    
    let description: String?
    let label: String?
    let amount: Int?
    let counterPartyName: String?
    let id: String?
    let dateEvent: String?
    let recipient: Actor?
    let sender: Actor?
    let status: String?
}
