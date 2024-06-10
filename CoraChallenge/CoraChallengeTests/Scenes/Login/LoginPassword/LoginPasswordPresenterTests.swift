import XCTest
@testable import CoraChallenge

final class LoginPasswordPresenterTests: XCTestCase {

    private let displayLogicSpy = DisplayLogicSpy()
    private lazy var sut = {
        let sut = LoginPasswordPresenter()
        sut.displayer = displayLogicSpy
        return sut
    }()
    
    func test_presentNextScene_whenMethodIsCalled_itShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayNextSceneCalls = 1
        
        // When
        sut.presentNextScene()
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayNextSceneCalls, expectedDisplayNextSceneCalls)
    }
    
    func test_presentNextSceneFailure_givenStubResponse_whenResponseIsPassedToMethod_itShouldPassCorrectErrorToDisplayer() {
        // Given
        let expectedDisplayNextSceneFailureCalls = 1
        let expectedErrorPassed: StubError = .stub
        let stubResponse = LoginPasswordModels.NextButton.Response.Failure(error: expectedErrorPassed)
        
        // When
        sut.presentNextSceneFailure(response: stubResponse)
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayNextSceneFailureParametersPassed.count, expectedDisplayNextSceneFailureCalls)
        XCTAssertEqual(
            displayLogicSpy.displayNextSceneFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }

}

extension LoginPasswordPresenterTests {
    
    final class DisplayLogicSpy: LoginPasswordDisplayLogic {
        
        private(set) var displayNextSceneCalls = 0
        func displayNextScene() {
            displayNextSceneCalls += 1
        }
        
        private(set) var displayNextSceneFailureParametersPassed = [LoginPasswordModels.NextButton.ViewModel.Failure]()
        func displayNextSceneFailure(viewModel: LoginPasswordModels.NextButton.ViewModel.Failure) {
            displayNextSceneFailureParametersPassed.append(viewModel)
        }
        
        
    }
    
}
