import XCTest
@testable import CoraChallenge

final class WelcomeInteractorTests: XCTestCase {
    private let presentationLogicSpy = PresentationLogicSpy()
    private lazy var sut = {
        WelcomeInteractor(presenter: presentationLogicSpy)
    }()
    
    func test_didTapLogin_whenMethodIsCalled_thenItShouldCallCorrectPresenterMethod() {
        // Given
        let expectedPresentLoginCalls = 1
        
        // When
        sut.didTapLogin()
        
        // Then
        XCTAssertEqual(presentationLogicSpy.presentLoginCalls, expectedPresentLoginCalls)
    }
    
}

// MARK: - Test Doubles
extension WelcomeInteractorTests {
    private final class PresentationLogicSpy: WelcomePresentationLogic {
        
        private(set) var presentLoginCalls = 0
        func presentLogin() {
            presentLoginCalls += 1
        }
    }
}
