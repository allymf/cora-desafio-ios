import XCTest
@testable import CoraChallenge

final class StatementDetailsInteractorTests: XCTestCase {}

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
