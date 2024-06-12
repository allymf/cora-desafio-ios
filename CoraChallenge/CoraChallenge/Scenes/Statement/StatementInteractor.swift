import Foundation

protocol StatementDataStore {
    var response: StatementResponse? { get }
}

protocol StatementBusinessLogic {
    func loadStatement()
    func didSelectItem(request: StatementModels.SelectItem.Request)
}

final class StatementInteractor: StatementBusinessLogic {
    
    private let presenter: StatementPresentationLogic
    private let worker: StatementWorkingLogic
    private let tokenStorage: TokenStoring
    
    private(set) var response: StatementResponse?
    
    init(
        presenter: StatementPresentationLogic,
        worker: StatementWorkingLogic = StatementWorker(),
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
                self?.response = response
                self?.presenter.presentLoadStatement(response: .init(response: response))
            case let .failure(error):
                self?.presenter.presentLoadStatementFailure(response: .init(error: error))
            }
        }
        
    }
    
    func didSelectItem(request: StatementModels.SelectItem.Request) {
        guard let section = response?.results?[safeIndex: request.indexPath.section],
              let item = section.items?[safeIndex: request.indexPath.item],
              let selectedItemId = item.id else {
            let error: StatementModels.SceneErrors = .itemUnavailable
            presenter.presentSelectedItemFailure(response: .init(error: error))
            return
        }
        presenter.presentSelectedItem(response: .init(id: selectedItemId))
    }
    
}
