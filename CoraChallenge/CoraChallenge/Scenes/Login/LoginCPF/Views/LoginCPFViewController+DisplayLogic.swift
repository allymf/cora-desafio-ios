import Foundation

protocol LoginCPFDisplayLogic: AnyObject {
    func displayCPF(viewModel: LoginCPFModels.ViewModel.Success)
    func displayCPFFailure(viewModel: LoginCPFModels.ViewModel.Failure)
}

extension LoginCPFViewController: LoginCPFDisplayLogic {
    func displayCPF(viewModel: LoginCPFModels.ViewModel.Success) {
        router.routeToLoginPassword()
    }
    
    func displayCPFFailure(viewModel: LoginCPFModels.ViewModel.Failure){
        debugPrint(viewModel.error)
    }
    
}
