import Foundation

public protocol WelcomePresentationLogic {}

final class WelcomePresenter: WelcomePresentationLogic {
    
    private(set) weak var displayer: WelcomeDisplayLogic?
    
    init(displayer: WelcomeDisplayLogic) {
        self.displayer = displayer
    }
    
}
