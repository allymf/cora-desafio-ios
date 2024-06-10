import Foundation

struct StatementResponse: Decodable {
    
    struct Section: Decodable{
        let items: [Item]?
        let date: String?
    }
    
    struct Item: Decodable {
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
