import Foundation

protocol LoginPasswordDataStore {
    var cpfText: String { get }
}

protocol LoginPasswordBusinessLogic {
    func didTapNextButton(request: LoginPasswordModels.NextButton.Request)
}
    
final class LoginPasswordInteractor: LoginPasswordBusinessLogic, LoginPasswordDataStore {
    private let presenter: LoginPasswordPresentationLogic
    private let worker: LoginPasswordWorkingLogic
    private let tokenStorage: TokenStoring
    
    // MARK: - DataStore
    private(set) var cpfText: String
    
    init(
        presenter: LoginPasswordPresentationLogic,
        worker: LoginPasswordWorkingLogic,
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
            // fail
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
                guard self.storeToken(response.token) else {
                    // Fail
                    return
                }
                // success
            case let .failure(error):
                // fail
                break
            }
        }
    }
    
    
    private func storeToken(_ token: String?) -> Bool {
        guard let token = token else { return false }
        do {
            try tokenStorage.save(token: token)
            return true
        } catch {
            return false
        }
    }
    
}
