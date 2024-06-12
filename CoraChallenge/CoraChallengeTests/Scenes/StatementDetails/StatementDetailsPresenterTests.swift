import XCTest
@testable import CoraChallenge

final class StatementDetailsPresenterTests: XCTestCase {}

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
