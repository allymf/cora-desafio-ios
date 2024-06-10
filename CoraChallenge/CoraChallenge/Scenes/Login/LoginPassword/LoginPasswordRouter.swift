import UIKit

protocol LoginPasswordRoutingLogic {
    func routeToStatement()
}

final class LoginPasswordRouter: LoginPasswordRoutingLogic {
    
    weak var viewController: UIViewController?
 
    func routeToStatement() {
        let statementViewController = StatementSceneFactory.makeScene()
        viewController?.show(
            statementViewController,
            sender: viewController
        )
    }
    
}
