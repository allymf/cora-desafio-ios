import Foundation

protocol TokenStoring {
    func save(token: String) throws
    
    func fetchToken() -> String?
}

struct TokenStorage: TokenStoring {
    
    static let service = "token"
    
    private let keychainManager: KeychainManaging
    
    init(keychainManager: KeychainManaging = KeychainManager()) {
        self.keychainManager = keychainManager
    }
    
    func save(token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainManager.KeychainError.invalidData
        }
        
        do {
            try keychainManager.save(
                data: data,
                service: TokenStorage.service
            )
        } catch KeychainManager.KeychainError.duplicateEntry {
            try keychainManager.update(
                data: data,
                forService: TokenStorage.service
            )
        }
    }
    
    func fetchToken() -> String? {
        guard let data = keychainManager.fetchData(fromService: TokenStorage.service) else {
            return nil
        }
        return String(
            data: data,
            encoding: .utf8
        )
    }
    
}
