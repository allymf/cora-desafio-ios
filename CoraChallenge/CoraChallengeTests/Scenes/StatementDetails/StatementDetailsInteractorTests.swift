import XCTest
@testable import CoraChallenge

final class StatementDetailsInteractorTests: XCTestCase {
    
    private let presentationLogicSpy = PresentationLogicSpy()
    private let workingLogicStub = WorkingLogicStub()
    private let tokenFetchingStub = TokenFetchingStub()
    private let stubItemId = UUID().uuidString
    private lazy var sut = {
        return StatementDetailsInteractor(
            presenter: presentationLogicSpy,
            worker: workingLogicStub,
            tokenStorage: tokenFetchingStub,
            itemId: stubItemId
        )
    }()
    
    func test_didLoad_givenTokenStorageWillReturnNil_whenMethodIsCalled_itShouldPassCorrectErrorToPresenter() {
        // Given
        tokenFetchingStub.fetchTokenValueToStub = nil
        
        let expectedFetchTokenCalls = 1
        let expectedPresentDetailsFailureCalls = 1
        let expectedErrorPassed: StatementDetailsModels.SceneErrors = .tokenIsNil
        
        // When
        sut.didLoad()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(presentationLogicSpy.presentDetailsFailureParametersPassed.count, expectedPresentDetailsFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentDetailsFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didLoad_givenTokenStorageWillTokenAndWorkerWillPassFailure_whenMethodIsCalled_itShouldPassCorrectErrorToPresenter() {
        // Given
        let stubToken = UUID().uuidString
        tokenFetchingStub.fetchTokenValueToStub = stubToken
        
        let expectedErrorPassed: NetworkLayerError = .noData
        workingLogicStub.getStatementDetailsValueToStub = .failure(expectedErrorPassed)
        
        let expectedFetchTokenCalls = 1
        let expectedGetStatementDetailsParametersPassed: [StatementDetailsModels.StatementDetailsParameters] = [
            .init(
                id: stubItemId,
                token: stubToken
            )
        ]
        let expectedPresentDetailsFailureCalls = 1
        
        // When
        sut.didLoad()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(workingLogicStub.getStatementDetailsParametersPassed, expectedGetStatementDetailsParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentDetailsFailureParametersPassed.count, expectedPresentDetailsFailureCalls)
        XCTAssertEqual(
            presentationLogicSpy.presentDetailsFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    func test_didLoad_givenTokenStorageWillTokenAndWorkerWillPassSuccess_whenMethodIsCalled_itShouldPassCorrectResponseToPresenter() {
        // Given
        let stubToken = UUID().uuidString
        tokenFetchingStub.fetchTokenValueToStub = stubToken
        
        let stubDecodable: StatementDetailsResponse = .fixture(id: UUID().uuidString)
        workingLogicStub.getStatementDetailsValueToStub = .success(stubDecodable)
        
        let expectedFetchTokenCalls = 1
        let expectedGetStatementDetailsParametersPassed: [StatementDetailsModels.StatementDetailsParameters] = [
            .init(
                id: stubItemId,
                token: stubToken
            )
        ]
        let expectedPresentDetailsParametersPassed: [StatementDetailsModels.DidLoad.Response.Success] = [
            .init(decodable: stubDecodable)
        ]
        
        // When
        sut.didLoad()
        
        // Then
        XCTAssertEqual(tokenFetchingStub.fetchTokenCalls, expectedFetchTokenCalls)
        XCTAssertEqual(workingLogicStub.getStatementDetailsParametersPassed, expectedGetStatementDetailsParametersPassed)
        XCTAssertEqual(presentationLogicSpy.presentDetailsParametersPassed, expectedPresentDetailsParametersPassed)
    }
    
}

extension StatementDetailsInteractorTests {
    
    final class PresentationLogicSpy: StatementDetailsPresentationLogic {
         
        private(set) var presentDetailsParametersPassed = [StatementDetailsModels.DidLoad.Response.Success]()
        func presentDetails(response: StatementDetailsModels.DidLoad.Response.Success) {
            presentDetailsParametersPassed.append(response)
        }
        
        private(set) var presentDetailsFailureParametersPassed = [StatementDetailsModels.DidLoad.Response.Failure]()
        func presentDetailsFailure(response: StatementDetailsModels.DidLoad.Response.Failure) {
            presentDetailsFailureParametersPassed.append(response)
        }
        
    }
    
    final class WorkingLogicStub: StatementDetailsWorkingLogic {
        
        private(set) var getStatementDetailsParametersPassed = [StatementDetailsModels.StatementDetailsParameters]()
        var getStatementDetailsValueToStub: Result<StatementDetailsResponse, NetworkLayerError> = .failure(.noData)
        func getStatementDetails(parameters: StatementDetailsModels.StatementDetailsParameters, completionHandler: @escaping (Result<StatementDetailsResponse, NetworkLayerError>) -> Void) {
            getStatementDetailsParametersPassed.append(parameters)
            completionHandler(getStatementDetailsValueToStub)
        }
        
        private(set) var cancelCurrentTaskCalls = 0
        func cancelCurrentTask() {
            cancelCurrentTaskCalls += 1
        }
    }
    
    final class TokenFetchingStub: TokenFetching {
        
        private(set) var fetchTokenCalls = 0
        var fetchTokenValueToStub: String?
        func fetchToken() -> String? {
            fetchTokenCalls += 1
            return fetchTokenValueToStub
        }
    }
    
}
