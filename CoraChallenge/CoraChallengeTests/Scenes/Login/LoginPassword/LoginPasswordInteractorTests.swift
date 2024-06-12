import XCTest
@testable import CoraChallenge

final class LoginPasswordInteractorTests: XCTestCase {

    private let presentationLogicSpy = PresentationLogicSpy()
    private let workingLogicStub = WorkingLogicStub()
    private let tokenStoringFake = TokenStoringFake()
    private let stubCPFText = UUID().uuidString
    private lazy var sut = LoginPasswordInteractor(
        presenter: presentationLogicSpy,
        worker: workingLogicStub,
        tokenStorage: tokenStoringFake,
        cpfText: stubCPFText
    )

    // MARK: - DidTapNextButton tests
    
    func test_didTapNextButton_givenNilPassword_whenRequestIsPassedToMethod_itShouldPassCorrectErrorToPresenter() {
        // Given
        let stubRequest = LoginPasswordModels.NextButton.Request(password: nil)
        let expectedPresentNextSceneFailureParametersPassed = 1
        let expectedErrorPassed: LoginPasswordModels.SceneErrors = .passwordIsNil
        
        // When
        sut.didTapNextButton(request: stubRequest)
        
        // Then
        XCTAssertEqual(presentationLogicSpy.presentNextSceneFailureParametersPassed.count, expectedPresentNextSceneFailureParametersPassed)
        XCTAssertEqual(
            presentationLogicSpy.presentNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didTapNextButton_givenPasswordValueAndWorkerWillReturnFailure_whenRequestIsPassedToMethod_itShouldPassCorrectErrorToPresenter() {
        // Given
        let stubPassword = UUID().uuidString
        let stubRequest = LoginPasswordModels.NextButton.Request(password: stubPassword)
        let expectedLoginParametersPassed = [
            LoginPasswordModels.LoginParameters(
                cpf: stubCPFText,
                password: stubPassword
            )
        ]
        
        let expectedPresentNextSceneFailureCalls = 1
        let expectedErrorPassed: NetworkLayerError = .noData
        
        workingLogicStub.loginResultToPass = .failure(expectedErrorPassed)
        
        // When
        sut.didTapNextButton(request: stubRequest)
        
        // Then
        XCTAssertEqual(workingLogicStub.loginParametersPassed, expectedLoginParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentNextSceneFailureParametersPassed.count, expectedPresentNextSceneFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didTapNextButton_givenPasswordValueAndWorkerWillReturnSuccessWithNilToken_whenRequestIsPassedToMethod_itShouldPassCorrectErrorToPresenter() {
        // Given
        let stubPassword = UUID().uuidString
        let stubRequest = LoginPasswordModels.NextButton.Request(password: stubPassword)
        let expectedLoginParametersPassed = [
            LoginPasswordModels.LoginParameters(
                cpf: stubCPFText,
                password: stubPassword
            )
        ]
        
        let expectedPresentNextSceneFailureCalls = 1
        let expectedErrorPassed: LoginPasswordModels.SceneErrors = .tokenIsNil
        let stubWorkerResponse = LoginResponse(token: nil)
        
        workingLogicStub.loginResultToPass = .success(stubWorkerResponse)
        
        // When
        sut.didTapNextButton(request: stubRequest)
        
        // Then
        XCTAssertEqual(workingLogicStub.loginParametersPassed, expectedLoginParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentNextSceneFailureParametersPassed.count, expectedPresentNextSceneFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didTapNextButton_givenPasswordValueAndWorkerWillReturnSuccessWithTokenValueAndTokenStorageWillNotSaveToken_whenRequestIsPassedToMethod_itShouldPassCorrectErrorToPresenter() {
        // Given
        let stubPassword = UUID().uuidString
        let stubRequest = LoginPasswordModels.NextButton.Request(password: stubPassword)
        let expectedLoginParametersPassed = [
            LoginPasswordModels.LoginParameters(
                cpf: stubCPFText,
                password: stubPassword
            )
        ]
        
        let stubToken = UUID().uuidString
        let stubWorkerResponse = LoginResponse(token: stubToken)
        
        let expectedSaveParametersPassed: [String?] = [stubToken]
        let expectedPresentNextSceneFailureCalls = 1
        let expectedErrorPassed: StubError = .stub
        
        workingLogicStub.loginResultToPass = .success(stubWorkerResponse)
        tokenStoringFake.saveErrorToThrow = expectedErrorPassed
        
        // When
        sut.didTapNextButton(request: stubRequest)
        
        // Then
        XCTAssertEqual(workingLogicStub.loginParametersPassed, expectedLoginParametersPassed)
        XCTAssertEqual(tokenStoringFake.saveParametersPassed, expectedSaveParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentNextSceneFailureParametersPassed.count, expectedPresentNextSceneFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didTapNextButton_givenPasswordValueAndWorkerWillReturnSuccessWithTokenValueAndTokenStorageWillSave_whenRequestIsPassedToMethod_itShouldCallCorrectMethodFromPresenter() {
        // Given
        let stubPassword = UUID().uuidString
        let stubRequest = LoginPasswordModels.NextButton.Request(password: stubPassword)
        let expectedLoginParametersPassed = [
            LoginPasswordModels.LoginParameters(
                cpf: stubCPFText,
                password: stubPassword
            )
        ]
        
        
        let expectedPresentNextSceneCalls = 1
        let stubToken = UUID().uuidString
        let expectedSaveParametersPassed = [stubToken]
        let stubWorkerResponse = LoginResponse(token: stubToken)
        
        workingLogicStub.loginResultToPass = .success(stubWorkerResponse)
        tokenStoringFake.saveErrorToThrow = nil
        
        
        // When
        sut.didTapNextButton(request: stubRequest)
        
        // Then
        XCTAssertEqual(workingLogicStub.loginParametersPassed, expectedLoginParametersPassed)
        XCTAssertEqual(tokenStoringFake.saveParametersPassed, expectedSaveParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentNextSceneCalls, expectedPresentNextSceneCalls)
    }
    
}

// MARK: - Test Doubles
extension LoginPasswordInteractorTests {
    
    final class PresentationLogicSpy: LoginPasswordPresentationLogic {
        
        private(set) var presentNextSceneCalls = 0
        func presentNextScene() {
            presentNextSceneCalls += 1
        }
        
        private(set) var presentNextSceneFailureParametersPassed = [LoginPasswordModels.NextButton.Response.Failure]()
        func presentNextSceneFailure(response: LoginPasswordModels.NextButton.Response.Failure) {
            presentNextSceneFailureParametersPassed.append(response)
        }
        
    }
    
    final class WorkingLogicStub: LoginPasswordWorkingLogic {
        
        private(set) var loginParametersPassed = [LoginPasswordModels.LoginParameters]()
        var loginResultToPass: Result<LoginResponse, NetworkLayerError> = .failure(.noData)
        func login(
            loginParameters: LoginPasswordModels.LoginParameters,
            completionHandler: @escaping (Result<LoginResponse, NetworkLayerError>) -> Void
        ) {
            loginParametersPassed.append(loginParameters)
            completionHandler(loginResultToPass)
        }
        
        private(set) var cancelCurrentTaskCalls = 0
        func cancelCurrentTask() {
            cancelCurrentTaskCalls += 1
        }
    }
    
    final class TokenStoringFake: TokenStoring {
        
        private(set) var saveParametersPassed = [String]()
        var saveErrorToThrow: StubError?
        func save(token: String) throws {
            saveParametersPassed.append(token)
            
            guard let saveErrorToThrow else {
                return
            }
            throw saveErrorToThrow
        }
        
        
    }
    
}
