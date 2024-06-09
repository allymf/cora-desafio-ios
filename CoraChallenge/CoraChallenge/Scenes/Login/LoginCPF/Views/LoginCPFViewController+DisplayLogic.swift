import Foundation

protocol LoginCPFDisplayLogic: AnyObject {
    func displayValidateCPF()
    func displayValidateCPFFailure()
    
    func displayNextScene()
    func displayNextSceneFailure(viewModel: LoginCPFModels.NextButton.ViewModel.Failure)
}

extension LoginCPFViewController: LoginCPFDisplayLogic {
    func displayValidateCPF() {
        viewProtocol.setNextButtonEnabled(true)
    }
    func displayValidateCPFFailure() {
        viewProtocol.setNextButtonEnabled(false)
    }
    
    func displayNextScene() {
        router.routeToLoginPassword()
    }
    
    func displayNextSceneFailure(viewModel: LoginCPFModels.NextButton.ViewModel.Failure){
        debugPrint(viewModel.error)
    }
    
}
