import UIKit

protocol StatementRoutingLogic {
    func routeToWelcome()
    func routeToStatementDetails()
}

final class StatementRouter: StatementRoutingLogic {
    
    weak var viewController: UIViewController?
    private let dataStore: StatementDataStore
    
    init(dataStore: StatementDataStore) {
        self.dataStore = dataStore
    }
    
    func routeToWelcome() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToStatementDetails() {
        guard let selectedId = dataStore.selectedId else { return }
        let statementDetailsViewController = StatementDetailsSceneFactory.makeScene(id: selectedId)
        viewController?.show(
            statementDetailsViewController,
            sender: viewController
        )
    }
    
}
