import Foundation

protocol StatementDetailsBusinessLogic {
    func didLoad()
}

final class StatementDetailsInteractor: StatementDetailsBusinessLogic {
    
    private let presenter: StatementDetailsPresentationLogic
    private let worker: StatementDetailsWorkingLogic
    private let tokenStorage: TokenStoring
    private let itemId: String
    
    init(
        presenter: StatementDetailsPresentationLogic,
        worker: StatementDetailsWorkingLogic = StatementDetailsWorker(),
        tokenStorage: TokenStoring = TokenStorage(),
        itemId: String
    ) {
        self.presenter = presenter
        self.worker = worker
        self.tokenStorage = tokenStorage
        self.itemId = itemId
    }
    
    func didLoad() {
        guard let token = tokenStorage.fetchToken() else {
            let error: StatementDetailsModels.SceneErrors = .tokenIsNil
            presenter.presentDetailsFailure(response: .init(error: error))
            return
        }
        
        let parameters = StatementDetailsParameters(
            id: itemId,
            token: token
        )
        worker.getStatementDetails(parameters: parameters) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(decodable):
                self.presenter.presentDetails(response: .init(decodable: decodable))
            case let .failure(error):
                self.presenter.presentDetailsFailure(response: .init(error: error))
            }
        }
    }
    
}
