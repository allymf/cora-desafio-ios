import UIKit

protocol StatementRoutingLogic {
    func routeToWelcome()
}

final class StatementRouter: StatementRoutingLogic {
    
    weak var viewController: UIViewController?
    
    func routeToWelcome() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
}
