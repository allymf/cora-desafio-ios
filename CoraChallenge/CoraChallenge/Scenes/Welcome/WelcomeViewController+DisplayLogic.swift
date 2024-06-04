import Foundation

public protocol WelcomeDisplayLogic: AnyObject {
    func displayLogin()
}

extension WelcomeViewController: WelcomeDisplayLogic {
    func displayLogin() {
        router.routeToLogin()
    }
}
