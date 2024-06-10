import Foundation

protocol KeychainManaging {
    func save(
        data: Data,
        service: String
    ) throws
    
    func fetchData(fromService service: String) -> Data?
    
    func update(
        data: Data,
        forService service: String
    ) throws
}

struct KeychainManager: KeychainManaging {
    
    enum KeychainError: Error {
        case invalidData
        case duplicateEntry
        case entryNotFound
        case unknown(OSStatus)
    }
    
    
    func save(
        data: Data,
        service: String
    ) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecAttrService: service,
            kSecValueData: data,
        ] as CFDictionary
        
        let status = SecItemAdd(
            query,
            nil
        )
        
        guard status != errSecDuplicateItem else {
            debugPrint("Can't add duplicate entry: ", data)
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            debugPrint("Error: ", status)
            throw KeychainError.unknown(status)
        }
    }
    
    func fetchData(fromService service: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true,
            kSecAttrService: service,
        ]
        
        var dateTypeReference: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &dateTypeReference
        )
        
        guard status == errSecSuccess, 
                let data = dateTypeReference as? Data else {
            return nil
        }
        
        return data
    }
    
    func update(
        data: Data,
        forService service: String
    ) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
        ] as CFDictionary
        
        let updateFields = [
          kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemUpdate(
            query,
            updateFields
        )
        
        guard status != errSecItemNotFound else {
            debugPrint("Can't update non existent item.")
            throw KeychainError.entryNotFound
        }
        
        guard status == errSecSuccess else {
            debugPrint("Error: ", status)
            throw KeychainError.unknown(status)
        }
        
    }
    
}
