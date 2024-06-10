import Foundation

protocol TokenStoring {
    func save(
        token: String,
        forService service: String
    ) throws
    
    func fetchToken(forService service: String) -> String?
}

struct TokenStorage: TokenStoring {
    
    static let service = "token"
    
    private let keychainManager: KeychainManaging
    
    init(keychainManager: KeychainManaging = KeychainManager()) {
        self.keychainManager = keychainManager
    }
    
    func save(
        token: String,
        forService service: String
    ) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainManager.KeychainError.invalidData
        }
        
        do {
            try keychainManager.save(
                data: data,
                service: service
            )
        } catch KeychainManager.KeychainError.duplicateEntry {
            try keychainManager.update(
                data: data,
                forService: service
            )
        }
    }
    
    func fetchToken(forService service: String) -> String? {
        guard let data = keychainManager.fetchData(fromService: service) else {
            return nil
        }
        return String(
            data: data,
            encoding: .utf8
        )
    }
    
}
