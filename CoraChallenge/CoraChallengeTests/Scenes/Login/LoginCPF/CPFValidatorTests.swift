import XCTest
@testable import CoraChallenge

final class CPFValidatorTests: XCTestCase {

    private let sut = CPFValidator()

    func test_validate_givenInvalidCPF_whenCPFIsPassedIntoMethod_itShouldReturnFalse() {
        // Given
        let stubCPFTexts: [String] = [
            "",
            "111.111.111-11",
            "222.222.222-22",
            "123.456.789-00",
            "170.382.421-00",
            "170.382.421-11",
            "170.382.421-10",
            "170.382.421-01",
            "17038242100",
            "17038242111",
            "1703824210",
            "17038242105121212",
            "aasdasds",
            "ABC.DEF.GHI-JK"
        ]
        
        let expectedValidateResults = Array.init(
            repeating: false,
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
    
    func test_validate_givenValidCPF_whenCPFIsPassedIntoMethod_itShouldReturnTrue() {
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
