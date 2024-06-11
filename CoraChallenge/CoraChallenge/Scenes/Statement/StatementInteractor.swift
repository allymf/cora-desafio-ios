import Foundation

protocol StatementBusinessLogic {
    func loadStatement()
}

protocol StatementDataStore {}

final class StatementInteractor: StatementBusinessLogic, StatementDataStore {
    
    private let presenter: StatementPresentationLogic
    private let worker: StatementWorkingLogic
    private let tokenStorage: TokenStoring
    
    init(
        presenter: StatementPresentationLogic,
        worker: StatementWorkingLogic,
        tokenStorage: TokenStoring = TokenStorage()
    ) {
        self.presenter = presenter
        self.worker = worker
        self.tokenStorage = tokenStorage
    }
    
    func loadStatement() {
        guard let token = tokenStorage.fetchToken() else {
            presenter.presentLogout()
            return
        }
        
        worker.getStatement(token: token) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.presentLoadStatement(response: .init(response: response))
            case let .failure(error):
                self?.presenter.presentLoadStatementFailure(response: .init(error: error))
            }
        }
        
    }
    
}
