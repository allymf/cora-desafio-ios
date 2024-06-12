import Foundation

protocol LoginPasswordDisplayLogic: AnyObject {
    func displayNextScene()
    func displayNextSceneFailure(viewModel: LoginPasswordModels.NextButton.ViewModel.Failure)
}

extension LoginPasswordViewController: LoginPasswordDisplayLogic {
    
    func displayNextScene() {
        DispatchQueue.main.async { [weak self] in
            self?.router.routeToStatement()
        }
    }
    
    func displayNextSceneFailure(viewModel: LoginPasswordModels.NextButton.ViewModel.Failure) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewProtocol.stopLoading()
            self.presentDefaultErrorAlert()
        }
        
        
        debugPrint("Error: ", viewModel.error.localizedDescription)
    }
    
}
