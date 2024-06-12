import UIKit

protocol StatementRoutingLogic {
    func routeToWelcome()
    func routeToStatementDetails(id: String)
}

final class StatementRouter: StatementRoutingLogic {
    
    weak var viewController: UIViewController?
    
    func routeToWelcome() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToStatementDetails(id: String) {
        let statementDetailsViewController = StatementDetailsSceneFactory.makeScene(id: id)
        viewController?.show(
            statementDetailsViewController,
            sender: viewController
        )
    }
    
}
