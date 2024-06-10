import Foundation

protocol StatementPresentationLogic {
    
    func presentLoadStatement(response: StatementModels.LoadStatement.Response.Success)
    func presentLoadStatementFailure(response: StatementModels.LoadStatement.Response.Failure)
    
    func presentLogout()
    
}

final class StatementPresenter: StatementPresentationLogic {
    
    weak var displayer: StatementDisplayLogic?
    
    func presentLoadStatement(response: StatementModels.LoadStatement.Response.Success) {}
    
    func presentLoadStatementFailure(response: StatementModels.LoadStatement.Response.Failure) {
        displayer?.displayLoadStatementFailure(viewModel: .init(error: response.error))
    }
    
    func presentLogout() {
        displayer?.displayLogout()
    }
    
}
