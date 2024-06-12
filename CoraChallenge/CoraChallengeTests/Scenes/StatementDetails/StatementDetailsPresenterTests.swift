import XCTest
@testable import CoraChallenge

final class StatementDetailsPresenterTests: XCTestCase {
    
    private let displayLogicSpy = DisplayLogicSpy()
    private let viewModelMappingStub = ViewModelMappingStub()
    private lazy var sut = {
        let sut = StatementDetailsPresenter(viewModelMapper: viewModelMappingStub)
        sut.displayer = displayLogicSpy
        return sut
    }()
    
    func test_givenStubDecodableAndStubSceneViewModel_whenStubResponseIsPassedToMethod_itShouldPassCorrectViewModelToDisplayer() {
        // Given
        let stubDecodableResponse: StatementDetailsResponse = .fixture(id: UUID().uuidString)
        let stubResponse = StatementDetailsModels.DidLoad.Response.Success(decodable: stubDecodableResponse)
        
        let stubSceneViewModel: StatementDetailsModels.StatementDetailViewModel = .fixture(title: UUID().uuidString)
        viewModelMappingStub.makeViewModelValueToReturn = stubSceneViewModel
        
        let expectedMakeViewModelParametersPassed = [stubDecodableResponse]
        let expectedDisplayDetailsParametersPassed: [StatementDetailsModels.DidLoad.ViewModel.Success] = [
            .init(sceneViewModel: stubSceneViewModel)
        ]
        
        // When
        sut.presentDetails(response: stubResponse)
        
        // Then
        XCTAssertEqual(viewModelMappingStub.makeViewModelParametersPassed, expectedMakeViewModelParametersPassed)
        XCTAssertEqual(displayLogicSpy.displayDetailsParametersPassed, expectedDisplayDetailsParametersPassed)
    }
    
    func test_presentDetailsFailure_givenStubError_whenStubResponseIsPassedToMethod_itShouldPassCorrectErrorToDisplayer() {
        // Given
        let expectedDisplayDetailsFailureCalls = 1
        let expectedErrorPassed: StubError = .stub
        let stubResponse = StatementDetailsModels.DidLoad.Response.Failure(error: expectedErrorPassed)
        
        // When
        sut.presentDetailsFailure(response: stubResponse)
        
        // Then
        XCTAssertEqual(displayLogicSpy.displayDetailsFailureParametersPassed.count, expectedDisplayDetailsFailureCalls)
        XCTAssertEqual(
            displayLogicSpy.displayDetailsFailureParametersPassed.first?.error.localizedDescription,
            expectedErrorPassed.localizedDescription
        )
    }
    
}

extension StatementDetailsPresenterTests {
    
    final class DisplayLogicSpy: StatementDetailsDisplayLogic {
        
        private(set) var displayDetailsParametersPassed = [StatementDetailsModels.DidLoad.ViewModel.Success]()
        func displayDetails(viewModel: StatementDetailsModels.DidLoad.ViewModel.Success) {
            displayDetailsParametersPassed.append(viewModel)
        }
        
        private(set) var displayDetailsFailureParametersPassed = [StatementDetailsModels.DidLoad.ViewModel.Failure]()
        func displayDetailsFailure(viewModel: StatementDetailsModels.DidLoad.ViewModel.Failure) {
            displayDetailsFailureParametersPassed.append(viewModel)
        }
        
    }
    
    final class ViewModelMappingStub: StatementDetailViewModelMapping {
        
        private(set) var makeViewModelParametersPassed = [StatementDetailsResponse]()
        var makeViewModelValueToReturn: StatementDetailsModels.StatementDetailViewModel = .fixture()
        func makeViewModel(with decodable: StatementDetailsResponse) -> StatementDetailsModels.StatementDetailViewModel {
            makeViewModelParametersPassed.append(decodable)
            return makeViewModelValueToReturn
        }
    }
    
}
