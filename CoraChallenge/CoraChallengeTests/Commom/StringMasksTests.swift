import XCTest
@testable import CoraChallenge

final class StringMasksTests: XCTestCase {

    func test_maskCPF_givenCorrectLength_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = "12345678910"
        let expectedResult = "123.456.789-10"
        
        // When
        let result = sut.maskCPF
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_maskCPF_givenIncorrectLength_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = "1234567891"
        let expectedResult = sut
        
        // When
        let result = sut.maskCPF
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_maskCNPJ_givenCorrectLengthValue_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = "99887766000112"
        let expectedResult = "99.887.766/0001-12"
        
        // When
        let result = sut.maskCNPJ
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_maskCNPJ_givenIncorrectLengthValue_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = "9988776600011"
        let expectedResult = sut
        
        // When
        let result = sut.maskCNPJ
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
}
