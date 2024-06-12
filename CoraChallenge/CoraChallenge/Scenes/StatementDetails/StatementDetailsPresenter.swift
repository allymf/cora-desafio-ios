import Foundation

protocol StatementDetailsPresentationLogic {
    
    func presentDetails(response: StatementDetailsModels.DidLoad.Response.Success)
    func presentDetailsFailure(response: StatementDetailsModels.DidLoad.Response.Failure)
    
}

final class StatementDetailsPresenter: StatementDetailsPresentationLogic {
    
    weak var displayer: StatementDetailsDisplayLogic?
    
    func presentDetails(response: StatementDetailsModels.DidLoad.Response.Success) {
        
    }
    
    func presentDetailsFailure(response: StatementDetailsModels.DidLoad.Response.Failure) {
        displayer?.displayDetailsFailure(viewModel: .init(error: response.error))
    }
    
}
