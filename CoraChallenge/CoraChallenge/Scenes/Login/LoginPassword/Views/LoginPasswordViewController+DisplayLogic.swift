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
        debugPrint("Error: ", viewModel.error.localizedDescription)
    }
    
}
