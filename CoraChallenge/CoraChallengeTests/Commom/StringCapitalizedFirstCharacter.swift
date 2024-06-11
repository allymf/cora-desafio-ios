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

}
