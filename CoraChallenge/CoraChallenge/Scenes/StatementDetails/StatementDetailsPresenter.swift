import Foundation

protocol StatementDetailsPresentationLogic {
    
    func presentDetails(response: StatementDetailsModels.DidLoad.Response.Success)
    func presentDetailsFailure(response: StatementDetailsModels.DidLoad.Response.Failure)
    
}

final class StatementDetailsPresenter: StatementDetailsPresentationLogic {
    
    weak var displayer: StatementDetailsDisplayLogic?
    private let viewModelMapper: StatementDetailViewModelMapping
    
    init(viewModelMapper: StatementDetailViewModelMapping = StatementDetailViewModelMapper()) {
        self.viewModelMapper = viewModelMapper
    }
    
    func presentDetails(response: StatementDetailsModels.DidLoad.Response.Success) {
        let sceneViewModel = viewModelMapper.makeViewModel(with: response.decodable)
        displayer?.displayDetails(viewModel: .init(sceneViewModel: sceneViewModel))
    }
    
    func presentDetailsFailure(response: StatementDetailsModels.DidLoad.Response.Failure) {
        displayer?.displayDetailsFailure(viewModel: .init(error: response.error))
    }
    
}
