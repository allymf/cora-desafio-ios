import Foundation

protocol StatementDetailsBusinessLogic {}

final class StatementDetailsInteractor: StatementDetailsBusinessLogic {
    
    private let presenter: StatementDetailsPresentationLogic
    private let worker: StatementDetailsWorkingLogic
    
    init(
        presenter: StatementDetailsPresentationLogic,
        worker: StatementDetailsWorkingLogic = StatementDetailsWorker()
    ) {
        self.presenter = presenter
        self.worker = worker
    }
    
}
