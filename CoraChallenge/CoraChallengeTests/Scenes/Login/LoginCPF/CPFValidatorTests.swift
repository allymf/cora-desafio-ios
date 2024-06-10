import XCTest
@testable import CoraChallenge

final class CPFValidatorTests: XCTestCase {

    private let sut = CPFValidator()

    
    // MARK: - Invalid CPF tests
    func test_validate_givenCPFWithInvalidFirstVerifyingDigit_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = "17038242155"
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    func test_validate_givenCPFWithInvalidSecondVerifyingDigit_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = "17038242106"
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    
    func test_validate_givenRepeatingNumberCPF_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = "111.111.111-11"
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    func test_validate_givenCPFWithIncorrectLength_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = "1703824210"
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    func test_validate_givenCPFTextWithoutDigits_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = "ABC.DEF.GHI-JK"
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    func test_validate_givenEmptyCPFText_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFText = ""
        let expectedValidateResult = false
        
        // When
        let result = sut.validate(cpf: stubCPFText)
        
        // Then
        XCTAssertEqual(result, expectedValidateResult)
    }
    
    
    // MARK: - Valid CPF tests
    
    func test_validate_givenValidCPFs_whenCPFIsPassedIntoMethod_itShouldReturnTrue() {
        // Given
        let stubCPFTexts: [String] = [
            "141.205.858-91",
            "591.630.386-68",
            "125.606.313-42",
            "695.972.916-57",
            "788.335.744-15",
            "17061266708",
            "24675056423",
            "84456463031",
            "50814650970",
            "22513423119",
            "00170080269"
        ]
        
        let expectedValidateResults = Array.init(
            repeating: true,
            count: stubCPFTexts.count
        )
        
        var validateResults = [Bool]()
        
        // When
        for stubCPFText in stubCPFTexts {
            validateResults.append(sut.validate(cpf: stubCPFText))
        }
        
        // Then
        XCTAssertEqual(validateResults, expectedValidateResults)
    }
    
}
