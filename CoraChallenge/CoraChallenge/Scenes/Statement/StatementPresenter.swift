import Foundation

protocol StatementPresentationLogic {
    
    func presentLoadStatement(response: StatementModels.LoadStatement.Response.Success)
    func presentLoadStatementFailure(response: StatementModels.LoadStatement.Response.Failure)
    
    func presentSelectedItem()
    func presentSelectedItemFailure(response: StatementModels.SelectItem.Response.Failure)
    
    func presentLogout()
    
}

final class StatementPresenter: StatementPresentationLogic {
    
    weak var displayer: StatementDisplayLogic?
    private let statementViewModelMapper: StatementViewModelMapping
    
    init(statementViewModelMapper: StatementViewModelMapping = StatementViewModelMapper()) {
        self.statementViewModelMapper = statementViewModelMapper
    }
    
    func presentLoadStatement(response: StatementModels.LoadStatement.Response.Success) {
        let statementViewModel = statementViewModelMapper.makeViewModel(with: response.response)
        displayer?.displayLoadStatement(viewModel: .init(sceneViewModel: statementViewModel))
    }
    
    func presentLoadStatementFailure(response: StatementModels.LoadStatement.Response.Failure) {
        displayer?.displayLoadStatementFailure(viewModel: .init(error: response.error))
    }
    
    func presentSelectedItem() {
        displayer?.displaySelectedItem()
    }
    
    func presentSelectedItemFailure(response: StatementModels.SelectItem.Response.Failure) {
        displayer?.displaySelectedItemFailure(viewModel: .init(error: response.error))
    }
    
    func presentLogout() {
        displayer?.displayLogout()
    }
    
}
