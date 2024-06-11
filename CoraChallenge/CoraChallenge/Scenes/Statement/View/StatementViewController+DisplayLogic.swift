import Foundation

protocol StatementDisplayLogic: AnyObject {
    func displayLoadStatement(viewModel: StatementModels.LoadStatement.ViewModel.Success)
    func displayLoadStatementFailure(viewModel: StatementModels.LoadStatement.ViewModel.Failure)
    
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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.present(
                self.makeErrorAlert(),
                animated: true
            )
        }
        debugPrint(viewModel.error.localizedDescription)
    }
    
    func displayLogout() {
        router.routeToWelcome()
    }
    
}
