import XCTest
@testable import CoraChallenge

final class StatementPresenterTests: XCTestCase {
    
    private let displayLogicSpy = DisplayLogicSpy()
    private let statementViewModelMappingStub = StatementViewModelMappingStub()
    private lazy var sut = {
        let sut = StatementPresenter(statementViewModelMapper: statementViewModelMappingStub)
        sut.displayer = displayLogicSpy
        return sut
    }()
    
    // MARK: - PresentLoadStatement tests
    func test_presentLoadStatement_givenStubResponse_whenResponseIsPasseToMethod_itShouldCallMapperAndPassCorrectViewModelToDisplayer() {
        // Given
        let stubStatementResponse: StatementResponse = .fixture()
        let stubResponse = StatementModels.LoadStatement.Response.Success(response: stubStatementResponse)
        
        let stubViewModel: StatementModels.StatementViewModel = .fixture()
        statementViewModelMappingStub.makeViewModelValueToStub = stubViewModel
        
        let expectedMakeViewModelParametersPassed = [stubStatementResponse]
        let expectedDisplayLoadStatementParametersPassed = [StatementModels.LoadStatement.ViewModel.Success(sceneViewModel: stubViewModel)]
        
        // When
        sut.presentLoadStatement(response: stubResponse)
        
        // Then
        XCTAssertEqual(statementViewModelMappingStub.makeViewModelParametersPassed, expectedMakeViewModelParametersPassed)
        XCTAssertEqual(displayLogicSpy.displayLoadStatementParametersPassed, expectedDisplayLoadStatementParametersPassed)
    }
    
    // MARK: - PresentLoadStatementFailure tests
    func test_presentLoadStatementFailure_givenStubResponse_whenResponseIsPassedToMethod_itShouldPassCorrectErrorToDisplayer() {
        // Given
        let expectedPresentLoadStatementFailureCalls = 1
        let expectedErrorPassed: StubError = .stub
        
        let stubResponse = StatementModels.LoadStatement.Response.Failure(error: expectedErrorPassed)
        
        // When
        sut.presentLoadStatementFailure(response: stubResponse)
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayLoadStatementFailureParametersPassed.count, expectedPresentLoadStatementFailureCalls)
        XCTAssertEqual(
            displayLogicSpy.displayLoadStatementFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
    // MARK: - PresentLogout tests
    func test_presentLogout_whenMethodIsCalled_itShouldCallCorrectMethodFromDisplayer() {
        // Given
        let expectedDisplayLogoutCalls = 1
        
        // When
        sut.presentLogout()
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayLogoutCalls, expectedDisplayLogoutCalls)
    }
    
}

// MARK: - Test Doubles
extension StatementPresenterTests {
    
    final class DisplayLogicSpy: StatementDisplayLogic {
        func displaySelectedItem() {
            
        }
        
        func displaySelectedItemFailure(viewModel: CoraChallenge.StatementModels.SelectItem.ViewModel.Failure) {
            
        }
        
        
        private(set) var displayLoadStatementParametersPassed = [StatementModels.LoadStatement.ViewModel.Success]()
        func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success) {
            displayLoadStatementParametersPassed.append(viewModel)
        }
        
        private(set) var displayLoadStatementFailureParametersPassed = [StatementModels.LoadStatement.ViewModel.Failure]()
        func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure) {
            displayLoadStatementFailureParametersPassed.append(viewModel)
        }
        
        private(set) var displayLogoutCalls = 0
        func displayLogout() {
            displayLogoutCalls += 1
        }
    }
 
    final class StatementViewModelMappingStub: StatementViewModelMapping {
        
        private(set) var makeViewModelParametersPassed = [StatementResponse]()
        var makeViewModelValueToStub: StatementModels.StatementViewModel = .fixture()
        func makeViewModel(with decodable: StatementResponse) -> StatementModels.StatementViewModel {
            makeViewModelParametersPassed.append(decodable)
            return makeViewModelValueToStub
        }
    }
    
}
