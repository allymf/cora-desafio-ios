import Foundation

import Foundation

protocol LoginCPFDataStore {
    var cpfText: String { get }
}

protocol LoginCPFBusinessLogic {
    func validateCPF(request: LoginCPFModels.ValidateCPF.Request)
    func didTapNextButton()
}

final class LoginCPFInteractor: LoginCPFBusinessLogic, LoginCPFDataStore {
    private let presenter: LoginCPFPresentationLogic
    private let cpfValidator: CPFValidating
    
    // MARK: - DataStore
    private(set) var cpfText: String = .init()
    
    init(
        presenter: LoginCPFPresentationLogic,
        cpfValidator: CPFValidating = CPFValidator()
    ) {
        self.presenter = presenter
        self.cpfValidator = cpfValidator
    }
    
    func validateCPF(request: LoginCPFModels.ValidateCPF.Request) {
        guard let cpfText = request.cpfText,
              cpfValidator.validate(cpf: cpfText) else {
            presenter.presentValidateCPFFailure()
            return
        }
        self.cpfText = cpfText
        presenter.presentValidateCPF()
    }
    
    func didTapNextButton() {
        guard !cpfText.isEmpty else {
            let response = LoginCPFModels.NextButton.Response.Failure(error: .CPFIsEmpty)
            presenter.presentNextSceneFailure(response: response)
            return
        }
        
        presenter.presentNextScene()
    }
    
}
