import Foundation

public protocol WelcomePresentationLogic {
    func presentLogin()
}

final class WelcomePresenter: WelcomePresentationLogic {
    
    weak var displayer: WelcomeDisplayLogic?
    
    func presentLogin() {
        displayer?.displayLogin()
    }
    
}
