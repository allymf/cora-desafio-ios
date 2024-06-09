import XCTest
@testable import CoraChallenge

final class LoginCPFInteractorTests: XCTestCase {

    private let presentationLogicSpy = PresentationLogicSpy()
    private let cpfValidatorFake = CPFValidatorFake()
    private lazy var sut = {
        let sut = LoginCPFInteractor(
            presenter: presentationLogicSpy,
            cpfValidator: cpfValidatorFake
        )
        return sut
    }()
    
    // MARK: - ValidateCPF tests
    func test_validate_givenNilCPFText_whenCPFTextIsPassedToMethod_itShouldCallCorrectMethodFromPresenter() {
        // Given
        let expectedPresentValidateCPFFailureCalls = 1
        let stubCPFText: String? = nil
        let stubRequest = LoginCPFModels.ValidateCPF.Request(cpfText: stubCPFText)
        
        // When
        sut.validateCPF(request: stubRequest)
        
        // Then
        XCTAssertTrue(cpfValidatorFake.validateParametersPassed.isEmpty)
        XCTAssertEqual(presentationLogicSpy.presentValidateCPFFailureCalls, expectedPresentValidateCPFFailureCalls)
    }
    
    func test_validate_givenCPFTextHasValueAndCPFValidatorReturnsFalse_whenCPFTextIsPassedToMethod_itShouldCallCorrectMethodFromPresenter() {
        // Given
        let stubCPFText = UUID().uuidString
        let stubRequest = LoginCPFModels.ValidateCPF.Request(cpfText: stubCPFText)
        
        cpfValidatorFake.validateReturnValue = false
        
        let expectedValidateParametersPassed = [stubCPFText]
        let expectedPresentValidateFailureCPFCalls = 1
        
        // When
        sut.validateCPF(request: stubRequest)
        
        // Then
        XCTAssertEqual(cpfValidatorFake.validateParametersPassed, expectedValidateParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentValidateCPFFailureCalls, expectedPresentValidateFailureCPFCalls)
    }
    
    func test_validate_givenCPFTextHasValueAndCPFValidatorReturnsTrue_whenCPFTextIsPassedToMethod_itShouldStoreCPFTextValueAndCallCorrectMethodFromPresenter() {
        // Given
        let expectedCPFText = UUID().uuidString
        let stubRequest = LoginCPFModels.ValidateCPF.Request(cpfText: expectedCPFText)
        
        cpfValidatorFake.validateReturnValue = true
        
        let expectedValidateParametersPassed = [expectedCPFText]
        let expectedPresentValidateCPFCalls = 1
        
        // When
        sut.validateCPF(request: stubRequest)
        
        // Then
        XCTAssertEqual(cpfValidatorFake.validateParametersPassed, expectedValidateParametersPassed)
        XCTAssertEqual(sut.cpfText, expectedCPFText)
        XCTAssertEqual(presentationLogicSpy.presentValidateCPFCalls, expectedPresentValidateCPFCalls)
    }
    

    // MARK: - DidTapNextButton tests
    func test_didTapNextButton_givenCPFHasValue_whenMethodIsCalled_itShouldCallCorrectMethodFromPresenter() {
        // Given
        let cpfText = UUID().uuidString
        let validateCPFRequest = LoginCPFModels.ValidateCPF.Request(cpfText: cpfText)
        
        cpfValidatorFake.validateReturnValue = true
        sut.validateCPF(request: validateCPFRequest)
        
        let expectedPresentNextSceneCalls = 1
        
        // When
        sut.didTapNextButton()
        
        // Then
        XCTAssertEqual(presentationLogicSpy.presentNextSceneCalls, expectedPresentNextSceneCalls)
    }
    
    func test_didTapNextButton_givenEmptyCPFString_whenMethodIsCalled_itShouldPassCorrectErrorToPresenter() {
        // Given
        let expectedPresentNextSceneFailureCalls = 1
        let expectedErrorPassed: LoginCPFModels.SceneError = .CPFIsEmpty
        
        // When
        sut.didTapNextButton()
        
        // Then
        XCTAssertEqual(presentationLogicSpy.presentNextSceneFailureParameters.count, expectedPresentNextSceneFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentNextSceneFailureParameters.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
}

extension LoginCPFInteractorTests {
    
    final class PresentationLogicSpy: LoginCPFPresentationLogic {
        
        private(set) var presentValidateCPFCalls = 0
        func presentValidateCPF() {
            presentValidateCPFCalls += 1
        }
        
        private(set) var presentValidateCPFFailureCalls = 0
        func presentValidateCPFFailure() {
            presentValidateCPFFailureCalls += 1
        }
        
        private(set) var presentNextSceneCalls = 0
        func presentNextScene() {
            presentNextSceneCalls += 1
        }
        
        private(set) var presentNextSceneFailureParameters = [LoginCPFModels.NextButton.Response.Failure]()
        func presentNextSceneFailure(response: LoginCPFModels.NextButton.Response.Failure) {
            presentNextSceneFailureParameters.append(response)
        }
        
    }
    
    final class CPFValidatorFake: CPFValidating {
        
        private(set) var validateParametersPassed = [String]()
        var validateReturnValue = false
        func validate(cpf: String) -> Bool {
            validateParametersPassed.append(cpf)
            return validateReturnValue
        }
        
    }
    
}
