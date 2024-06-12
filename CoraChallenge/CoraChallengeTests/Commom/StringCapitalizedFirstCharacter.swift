import XCTest
@testable import CoraChallenge

final class StringCapitalizedFirstCharacter: XCTestCase {

    func test_capitalizedFirstCharacter_givenValue_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = "terça-feira"
        let expectedResult = "Terça-feira"
        
        // When
        let result = sut.capitalizedFirstCharacter
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_capitalizedFirstCharacter_givenEmptyValue_whenVariableIsCalled_itShouldReturnCorrectValue() {
        // Given
        let sut = ""
        let expectedResult = sut
        
        // When
        let result = sut.capitalizedFirstCharacter
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }

}
