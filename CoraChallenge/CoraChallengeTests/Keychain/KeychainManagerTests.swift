import XCTest
@testable import CoraChallenge

final class KeychainManagerTests: XCTestCase {
    
    private let sut = KeychainManager()
    private lazy var stubService = name
    
    private lazy var testQuery: [CFString: Any] = [
        kSecAttrService: stubService,
        kSecClass: kSecClassGenericPassword
    ]
    
    override func tearDownWithError() throws {
        SecItemDelete(testQuery as CFDictionary)
    }
    
    func test_fetchData_givenStubDataToStore_whenServiceIsPassedToMethod_itShouldReturnCorrectData() throws {
        // Given
        let stubData = try XCTUnwrap(UUID().uuidString.data(using: .utf8))
        
        try sut.save(
            data: stubData,
            service: stubService
        )
        
        // When
        let result = sut.fetchData(fromService: stubService)
        
        // Then
        XCTAssertEqual(result, stubData)
    }
    
    func test_update_givenEntryExists_whenParametersArePassed_itShouldUpdateDataInKeychain() throws {
        // Given
        let stubSaveData = try XCTUnwrap(UUID().uuidString.data(using: .utf8))
        let stubUpdateData = try XCTUnwrap(UUID().uuidString.data(using: .utf8))
        
        try sut.save(
            data: stubSaveData,
            service: stubService
        )
        
        // When
        try sut.update(
            data: stubUpdateData,
            forService: stubService
        )
        
        let result = sut.fetchData(fromService: stubService)
        
        // Given
        XCTAssertEqual(result, stubUpdateData)
    }
    
}
