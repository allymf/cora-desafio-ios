import Foundation

protocol StatementDisplayLogic: AnyObject {
    func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success)
    func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure)
    
    func displayLogout()
}

extension StatementViewController: StatementDisplayLogic {
    
    func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success) {}
    
    func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure) {
        debugPrint(viewModel.error.localizedDescription)
    }
    
    func displayLogout() {
        // Route to Welcome
    }
    
}
