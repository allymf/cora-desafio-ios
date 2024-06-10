import XCTest
@testable import CoraChallenge

final class StringUnmaskedCPFTests: XCTestCase {

    let sut = "123.456.789-00"
    
    func test_unmaskedCPF_givenMaskedCPFValue_whenVariableIsAccessed_itShouldHaveUnmaskedValue() {
        // Given
        let sut = "123.456.789-00"
        let expectedResult = "12345678900"
        
        // When
        let result = sut.unmaskedCPF
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }

}
