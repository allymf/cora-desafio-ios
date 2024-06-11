import Foundation

struct StatementResponse: Decodable, Equatable {
    
    struct Section: Decodable, Equatable {
        let items: [Item]?
        let date: String?
    }
    
    struct Item: Decodable, Equatable {
        let id: String?
        let description: String?
        let label: String?
        let entry: String?
        let amount: Int?
        let name: String?
        let dateEvent: String?
        let status: String?
    }
    
    let results: [Section]?
    let itemsTotal: Int?
    
}
