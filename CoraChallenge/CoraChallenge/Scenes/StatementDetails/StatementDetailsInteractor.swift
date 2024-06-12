import Foundation

protocol StatementDetailsBusinessLogic {}

final class StatementDetailsInteractor: StatementDetailsBusinessLogic {
    
    private let presenter: StatementDetailsPresentationLogic
    private let worker: StatementDetailsWorkingLogic
    private let itemId: String
    
    init(
        presenter: StatementDetailsPresentationLogic,
        worker: StatementDetailsWorkingLogic = StatementDetailsWorker(),
        itemId: String
    ) {
        self.presenter = presenter
        self.worker = worker
        self.itemId = itemId
    }
    
}
