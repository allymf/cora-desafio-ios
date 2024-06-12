import Foundation

protocol StatementDetailsDisplayLogic: AnyObject {
    
    func displayDetails(viewModel: StatementDetailsModels.DidLoad.ViewModel.Success)
    func displayDetailsFailure(viewModel: StatementDetailsModels.DidLoad.ViewModel.Failure)
    
}

extension StatementDetailsViewController: StatementDetailsDisplayLogic {
    
    func displayDetails(viewModel: StatementDetailsModels.DidLoad.ViewModel.Success) {
        DispatchQueue.main.async { [weak self] in
            self?.viewProtocol.setup(with: viewModel.sceneViewModel)
        }
    }
    
    func displayDetailsFailure(viewModel: StatementDetailsModels.DidLoad.ViewModel.Failure) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.presentDefaultErrorAlert {
                self.navigationController?.popViewController(animated: true)
            }
        }
        debugPrint("Error: ", viewModel.error)
    }
    
}
