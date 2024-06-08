import Foundation

protocol LoginCPFPresentationLogic {
    
    func presentValidateCPF()
    func presentValidateCPFFailure()
    
    func presentNextScene()
    func presentNextSceneFailure(response: LoginCPFModels.NextButton.Response.Failure)
}

final class LoginCPFPresenter: LoginCPFPresentationLogic {
    
    weak var displayer: LoginCPFDisplayLogic?
    
    func presentValidateCPF() {
        displayer?.displayValidateCPF()
    }
    
    func presentValidateCPFFailure() {
        displayer?.displayValidateCPFFailure()
    }
    
    func presentNextScene() {
        displayer?.displayNextScene()
    }
    
    func presentNextSceneFailure(response: LoginCPFModels.NextButton.Response.Failure) {
        displayer?.displayNextSceneFailure(viewModel: .init(error: response.error))
    }
    
}
