import XCTest
@testable import CoraChallenge

final class StatementInteractorTests: XCTestCase {
    
    private let presentationLogicSpy = PresentationLogicSpy()
    private let workingLogicSpy = WorkingLogicStub()
    private let tokenFetchingStub = TokenFetchingStub()
    private lazy var sut = {
        return StatementInteractor(
            presenter: presentationLogicSpy,
            worker: workingLogicSpy,
            tokenStorage: tokenFetchingStub
        )
    }()
    
    func test_loadStatement_givenTokenStorageWillNotReturnToken_whenMethodIsCalled_itShouldCallCorrectMethodFromPresenter() {
        // Given
        tokenFetchingStub.fetchTokenValueToReturn = nil
        
        let expectedFetchTokenCalls = 1
        let expectedPresentLogoutCalls = 1
        
        // When
        sut.loadStatement()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(presentationLogicSpy.presentLogoutCalls, expectedPresentLogoutCalls)
    }
    
    func test_loadStatement_givenTokenStorageWillReturnTokenAndWorkerWillPassFailure_whenMethodIsCalled_itShouldPassCorrectErrorToPresenter() {
        // Given
        let expectedToken = UUID().uuidString
        tokenFetchingStub.fetchTokenValueToReturn = expectedToken
        
        let expectedErrorPassed: NetworkLayerError = .noData
        
        workingLogicSpy.getStatementValueToStub = .failure(expectedErrorPassed)
        
        let expectedFetchTokenCalls = 1
        let expectedGetStatementParametersPassed = [expectedToken]
        let expectedPresentLoadStatementFailureParametersPassed = 1
        
        // When
        sut.loadStatement()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(workingLogicSpy.getStatementParametersPassed, expectedGetStatementParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentLoadStatementFailureParametersPassed.count, expectedPresentLoadStatementFailureParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentLoadStatementFailureParametersPassed.first?.error.localizedDescription, expectedErrorPassed.localizedDescription)
    }
    
    func test_loadStatement_givenTokenStorageWillReturnTokenAndWorkerWillPassSuccess_whenMethodIsCalled_itShouldPassCorrectResponseToPresenter() {
        // Given
        let expectedToken = UUID().uuidString
        tokenFetchingStub.fetchTokenValueToReturn = expectedToken
        
        let stubResponse: StatementResponse = .fixture()
        workingLogicSpy.getStatementValueToStub = .success(stubResponse)
        
        let expectedFetchTokenCalls = 1
        let expectedGetStatementParametersPassed = [expectedToken]
        let expectedPresentLoadStatementParametersPassed = [StatementModels.LoadStatement.Response.Success(response: stubResponse)]
        
        // When
        sut.loadStatement()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(workingLogicSpy.getStatementParametersPassed, expectedGetStatementParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentLoadStatementParametersPassed, expectedPresentLoadStatementParametersPassed)
    }
    
}

// MARK: - Test doubles
extension StatementInteractorTests {
    
    final class PresentationLogicSpy: StatementPresentationLogic {
        func presentSelectedItem() {
            
        }
        
        func presentSelectedItemFailure(response: CoraChallenge.StatementModels.SelectItem.Response.Failure) {
            
        }
        
        
        private(set) var presentLoadStatementParametersPassed = [StatementModels.LoadStatement.Response.Success]()
        func presentLoadStatement(response: StatementModels.LoadStatement.Response.Success) {
            presentLoadStatementParametersPassed.append(response)
        }
        
        private(set) var presentLoadStatementFailureParametersPassed = [StatementModels.LoadStatement.Response.Failure]()
        func presentLoadStatementFailure(response: StatementModels.LoadStatement.Response.Failure) {
            presentLoadStatementFailureParametersPassed.append(response)
        }
        
        private(set) var presentLogoutCalls = 0
        func presentLogout() {
            presentLogoutCalls += 1
        }
    }
    
    final class WorkingLogicStub: StatementWorkingLogic {
        
        private(set) var getStatementParametersPassed = [String]()
        var getStatementValueToStub: Result<StatementResponse, NetworkLayerError> = .failure(.noData)
        func getStatement(
            token: String,
            completionHandler: @escaping (Result<StatementResponse, NetworkLayerError>) -> Void
        ) {
            getStatementParametersPassed.append(token)
            completionHandler(getStatementValueToStub)
        }
        
        private(set) var cancelCurrentTaskCalls = 0
        func cancelCurrentTask() {
            cancelCurrentTaskCalls += 1
        }
        
    }
    
    final class TokenFetchingStub: TokenFetching {
        
        private(set) var fetchTokenCalls = 0
        var fetchTokenValueToReturn: String?
        func fetchToken() -> String? {
            fetchTokenCalls += 1
            return fetchTokenValueToReturn
        }
    }
    
}
