import Foundation

protocol StatementBusinessLogic {}

protocol StatementDataStore {}

final class StatementInteractor: StatementBusinessLogic, StatementDataStore {
    
    private let presenter: StatementPresentationLogic
    private let worker: StatementWorkingLogic
    
    init(
        presenter: StatementPresentationLogic,
        worker: StatementWorkingLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }
    
}
