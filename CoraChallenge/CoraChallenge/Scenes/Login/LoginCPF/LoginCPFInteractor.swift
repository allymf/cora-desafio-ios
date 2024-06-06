import Foundation

protocol LoginCPFDataStore {
    var cpfText: String { get }
}

protocol LoginCPFBusinessLogic {
    
    func didTapNextButton(request: LoginCPFModels.Request)
    
}

final class LoginCPFInteractor: LoginCPFBusinessLogic, LoginCPFDataStore {
    private let presenter: LoginCPFPresentationLogic
    
    // MARK: - DataStore
    private(set) var cpfText: String = .init()
    
    init(presenter: LoginCPFPresentationLogic) {
        self.presenter = presenter
    }
    
    func didTapNextButton(request: LoginCPFModels.Request) {
        guard let cpfText = request.cpfText,
              !cpfText.isEmpty else {
            let response = LoginCPFModels.Response.Failure(error: .CPFIsEmpty)
            presenter.presentCPFFailure(response: response)
            return
        }
        
        self.cpfText = cpfText
        
        presenter.presentCPF(response: .init())
    }
    
}
