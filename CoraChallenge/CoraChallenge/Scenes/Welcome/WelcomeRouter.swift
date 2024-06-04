import UIKit

protocol WelcomeRoutingLogic {
    func routeToLogin()
}

final class WelcomeRouter: WelcomeRoutingLogic {
    
    weak var viewController: WelcomeViewController?
    
    func routeToLogin() {
        let nextViewController = UIViewController()
        nextViewController.view.backgroundColor = .cyan
        viewController?.present(nextViewController, animated: true)
    }
    
}
