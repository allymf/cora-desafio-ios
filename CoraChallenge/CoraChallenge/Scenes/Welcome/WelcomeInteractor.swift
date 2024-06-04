import Foundation

public protocol WelcomeBusinessLogic {
    func didTapLogin()
}
public protocol WelcomeDataStore {}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    
    private let presenter: WelcomePresentationLogic
    
    init(presenter: WelcomePresentationLogic) {
        self.presenter = presenter
    }
    
    func didTapLogin() {
        presenter.presentLogin()
    }
    
}
