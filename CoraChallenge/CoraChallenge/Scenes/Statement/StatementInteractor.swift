import Foundation

protocol StatementBusinessLogic {}

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
    
}
