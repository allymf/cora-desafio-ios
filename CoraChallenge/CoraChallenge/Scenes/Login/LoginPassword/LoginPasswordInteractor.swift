import Foundation

protocol LoginPasswordBusinessLogic {
    func didTapNextButton(request: LoginPasswordModels.NextButton.Request)
}
    
final class LoginPasswordInteractor: LoginPasswordBusinessLogic {
    private let presenter: LoginPasswordPresentationLogic
    private let worker: LoginPasswordWorkingLogic
    private let tokenStorage: TokenStoring
    private let cpfText: String
    
    init(
        presenter: LoginPasswordPresentationLogic,
        worker: LoginPasswordWorkingLogic = LoginPasswordWorker(),
        tokenStorage: TokenStoring = TokenStorage(),
        cpfText: String
    ) {
        self.presenter = presenter
        self.worker = worker
        self.tokenStorage = tokenStorage
        self.cpfText = cpfText
    }
    
    func didTapNextButton(request: LoginPasswordModels.NextButton.Request) {
        guard let password = request.password else {
            let error: LoginPasswordModels.SceneErrors = .passwordIsNil
            presenter.presentNextSceneFailure(response: .init(error: error))
            return
        }
        
        let loginParameters = LoginPasswordModels.LoginParameters(
            cpf: cpfText,
            password: password
        )
        worker.login(loginParameters: loginParameters) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                handleTokenStorage(response.token)
            case let .failure(error):
                self.presenter.presentNextSceneFailure(response: .init(error: error))
                break
            }
        }
    }
    
    private func handleTokenStorage(_ token: String?) {
        guard let token = token else {
            let error: LoginPasswordModels.SceneErrors = .tokenIsNil
            return presenter.presentNextSceneFailure(response: .init(error: error))
        }
        
        do {
            try tokenStorage.save(token: token)
            presenter.presentNextScene()
        } catch {
            presenter.presentNextSceneFailure(response: .init(error: error))
        }
    }
    
}
