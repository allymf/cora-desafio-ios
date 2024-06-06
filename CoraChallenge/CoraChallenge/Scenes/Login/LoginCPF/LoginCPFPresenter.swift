import Foundation

protocol LoginCPFPresentationLogic {
    func presentCPF(response: LoginCPFModels.Response.Success)
    func presentCPFFailure(response: LoginCPFModels.Response.Failure)
}

final class LoginCPFPresenter: LoginCPFPresentationLogic {
    
    weak var displayer: LoginCPFDisplayLogic?
    
    func presentCPF(response: LoginCPFModels.Response.Success) {
        displayer?.displayCPF(viewModel: .init())
    }
    
    func presentCPFFailure(response: LoginCPFModels.Response.Failure) {
        displayer?.displayCPFFailure(viewModel: .init(error: response.error))
    }
    
}
