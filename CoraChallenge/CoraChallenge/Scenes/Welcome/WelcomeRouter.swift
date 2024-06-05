import UIKit

protocol WelcomeRoutingLogic {
    func routeToLogin()
}

final class WelcomeRouter: WelcomeRoutingLogic {
    
    weak var viewController: WelcomeViewController?
    
    func routeToLogin() {
        let loginCPFViewController = LoginCPFSceneFactory.makeScene()
        viewController?.show(
            loginCPFViewController,
            sender: viewController
        )
    }
    
}
