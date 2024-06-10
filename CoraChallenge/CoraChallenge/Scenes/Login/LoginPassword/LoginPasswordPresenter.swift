import Foundation

protocol LoginPasswordPresentationLogic {
    func presentNextScene()
    func presentNextSceneFailure(response: LoginPasswordModels.NextButton.Response.Failure)
}

final class LoginPasswordPresenter: LoginPasswordPresentationLogic {
    
    weak var displayer: LoginPasswordDisplayLogic?
    
    func presentNextScene() {
        displayer?.displayNextScene()
    }
    
    func presentNextSceneFailure(response: LoginPasswordModels.NextButton.Response.Failure) {
        displayer?.displayNextSceneFailure(viewModel: .init(error: response.error))
    }
    
}
