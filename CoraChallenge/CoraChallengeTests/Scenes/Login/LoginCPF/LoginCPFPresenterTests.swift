import XCTest
@testable import CoraChallenge

final class LoginCPFPresenterTests: XCTestCase {

    private let displayLogicSpy = DisplayLogicSpy()
    private lazy var sut = {
        let sut = LoginCPFPresenter()
        sut.displayer = displayLogicSpy
        return sut
    }()

    func test_presentValidateCPF_whenMethodIsCalled_itShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayValidateCPFCalls = 1
        
        // When
        sut.presentValidateCPF()
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayValidateCPFCalls, expectedDisplayValidateCPFCalls)
    }
    
    func test_presentValidateCPFFailure_whenMethodIsCalled_itShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayValidateCPFFailureCalls = 1
        
        // When
        sut.presentValidateCPFFailure()
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayValidateCPFFailureCalls, expectedDisplayValidateCPFFailureCalls)
    }
    
    func test_presentNextScene_whenMethodIsCalled_itShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayNextSceneCalls = 1
        
        // When
        sut.presentNextScene()
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayNextSceneCalls, expectedDisplayNextSceneCalls)
    }
    
    func test_presentNextSceneFailure_whenMethodIsCalled_itShouldPassCorrectErrorToDisplayer() {
        // Given
        let expectedPresentNextSceneFailureCalls = 1
        let expectedErrorPassed: LoginCPFModels.SceneError = .CPFIsEmpty
        
        let stubResponse = LoginCPFModels.NextButton.Response.Failure(error: expectedErrorPassed)
        
        // When
        sut.presentNextSceneFailure(response: stubResponse)
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayNextSceneFailureParametersPassed.count, expectedPresentNextSceneFailureCalls)
        XCTAssertEqual(
            displayLogicSpy.displayNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
}

extension LoginCPFPresenterTests {
    
    final class DisplayLogicSpy: LoginCPFDisplayLogic {
        
        private(set) var displayValidateCPFCalls = 0
        func displayValidateCPF() {
            displayValidateCPFCalls += 1
        }
        
        private(set) var displayValidateCPFFailureCalls = 0
        func displayValidateCPFFailure() {
            displayValidateCPFFailureCalls += 1
        }
        
        private(set) var displayNextSceneCalls = 0
        func displayNextScene() {
            displayNextSceneCalls += 1
        }
        
        private(set) var displayNextSceneFailureParametersPassed = [LoginCPFModels.NextButton.ViewModel.Failure]()
        func displayNextSceneFailure(viewModel: LoginCPFModels.NextButton.ViewModel.Failure) {
            displayNextSceneFailureParametersPassed.append(viewModel)
        }
    }
    
}
