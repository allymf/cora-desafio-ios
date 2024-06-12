import Foundation

protocol StatementDisplayLogic: AnyObject {
    func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success)
    func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure)
    
    func displaySelectedItem(viewModel: StatementModels.SelectItem.ViewModel.Success)
    func displaySelectedItemFailure(viewModel: StatementModels.SelectItem.ViewModel.Failure)
    
    func displayLogout()
}

extension StatementViewController: StatementDisplayLogic {
    
    func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success) {
        self.viewModel = viewModel.sceneViewModel
        
        DispatchQueue.main.async { [weak self] in
            self?.viewProtocol.reloadTableView()
        }
    }
    
    func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure) {
        handleError(viewModel.error)
    }
    
    func displaySelectedItem(viewModel: StatementModels.SelectItem.ViewModel.Success) {
        router.routeToStatementDetails(id: viewModel.id)
    }
    
    func displaySelectedItemFailure(viewModel: StatementModels.SelectItem.ViewModel.Failure) {
        handleError(viewModel.error)
    }
    
    func handleError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.presentDefaultErrorAlert()
        }
        debugPrint(error.localizedDescription)
    }
    
    
    func displayLogout() {
        router.routeToWelcome()
    }
    
}
