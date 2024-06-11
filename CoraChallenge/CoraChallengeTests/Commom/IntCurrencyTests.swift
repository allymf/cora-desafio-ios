import XCTest
@testable import CoraChallenge

final class IntCurrencyTests: XCTestCase {

    func test_currency_givenValue_whenVariableIsCalled_itShouldReturnValueDividedByOneHundred() {
        // Given
        let sut = 100
        let expectedResult = Double(100) / 100.0
        
        // When
        let result = sut.currency
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }

}
