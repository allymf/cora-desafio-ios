import XCTest
@testable import CoraChallenge

final class TokenStorageTests: XCTestCase {

    private let keychainManagingSpy = KeychainManagingSpy ()
    private lazy var sut = {
        TokenStorage(keychainManager: keychainManagingSpy)
    }()
    
    // MARK: - Save tests
    func test_save_givenKeychainManagerWillNotThrowError_whenMethodIsCalled_itShouldPassCorrectParametersToKeychainManager() throws {
        // Given
        let stubToken = UUID().uuidString
        let stubService = UUID().uuidString
        let expectedData = try XCTUnwrap(stubToken.data(using: .utf8))
        
        let expectedSaveParametersPassed: [KeychainManagingSpy.SaveParameters] = [
            .init(
                data: expectedData,
                service: stubService
            )
        ]
        
        keychainManagingSpy.saveErrorToThrow = nil
        
        // When
        try sut.save(
            token: stubToken,
            forService: stubService
        )
        
        // Then
        XCTAssertEqual(keychainManagingSpy.saveParametersPassed, expectedSaveParametersPassed)
        
    }
    
    func test_save_givenKeychainManagerSaveThrowsDuplicateErrorAndUpdateSucceeds_whenMethodIsCalled_itShouldPassCorrectParametersToKeychainManager() throws {
        // Given
        let stubToken = UUID().uuidString
        let stubService = UUID().uuidString
        let expectedData = try XCTUnwrap(stubToken.data(using: .utf8))
        
        let expectedSaveParametersPassed: [KeychainManagingSpy.SaveParameters] = [
            .init(
                data: expectedData,
                service: stubService
            )
        ]
        
        let expectedUpdateParametersPassed: [KeychainManagingSpy.UpdateParameters] = [
            .init(
                data: expectedData,
                service: stubService
            )
        ]
        
        keychainManagingSpy.saveErrorToThrow = KeychainManager.KeychainError.duplicateEntry
        keychainManagingSpy.updateErrorToThrow = nil
        
        // When
        try sut.save(
            token: stubToken,
            forService: stubService
        )
        
        // Then
        XCTAssertEqual(keychainManagingSpy.saveParametersPassed, expectedSaveParametersPassed)
        XCTAssertEqual(keychainManagingSpy.updateParametersPassed, expectedUpdateParametersPassed)
        
    }
    
    
    // MARK: - Fetch tests
    func test_givenKeychainWillReturnValueToFetchRequest_whenParametersArePassed_itShouldPassCorrectParametersToKeychainManagerAndReturnCorrectValue() {
        // Given
        let stubService = UUID().uuidString
        let expectedResult = UUID().uuidString
        let stubFetchResult = expectedResult.data(using: .utf8)
        let expectedFetchDataParametersPassed = [stubService]
        
        keychainManagingSpy.fetchDataResult = stubFetchResult
        
        // When
        let result = sut.fetchToken(forService: stubService)
        
        // Then
        XCTAssertEqual(keychainManagingSpy.fetchDataParametersPassed, expectedFetchDataParametersPassed)
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_givenKeychainWillNotReturnValueToFetchRequest_whenParametersArePassed_itShouldPassCorrectParametersToKeychainManagerAndReturnNil() {
        // Given
        let stubService = UUID().uuidString
        let stubFetchResult = UUID().uuidString.data(using: .utf8)
        let expectedFetchDataParametersPassed = [stubService]
        
        keychainManagingSpy.fetchDataResult = nil
        
        // When
        let result = sut.fetchToken(forService: stubService)
        
        // Then
        XCTAssertEqual(keychainManagingSpy.fetchDataParametersPassed, expectedFetchDataParametersPassed)
        XCTAssertNil(result)
    }
    
    
}

extension TokenStorageTests {
    
    final class KeychainManagingSpy: KeychainManaging {
        
        struct SaveParameters: Equatable {
            let data: Data
            let service: String
        }
        
        private(set) var saveParametersPassed = [SaveParameters]()
        var saveErrorToThrow: Error?
        func save(
            data: Data,
            service: String
        ) throws {
            saveParametersPassed.append(
                .init(
                    data: data,
                    service: service
                )
            )
            
            guard let error = saveErrorToThrow else {
                return
            }
            
            throw error
        }
        
        private(set) var fetchDataParametersPassed = [String]()
        var fetchDataResult: Data?
        func fetchData(fromService service: String) -> Data? {
            fetchDataParametersPassed.append(service)
            return fetchDataResult
        }
        
        
        struct UpdateParameters: Equatable {
            let data: Data
            let service: String
        }
        
        private(set) var updateParametersPassed = [UpdateParameters]()
        var updateErrorToThrow: Error?
        func update(data: Data, forService service: String) throws {
            updateParametersPassed.append(
                .init(
                    data: data,
                    service: service
                )
            )
            
            guard let error = updateErrorToThrow else {
                return
            }
            
            throw error
        }
    }
    
}
