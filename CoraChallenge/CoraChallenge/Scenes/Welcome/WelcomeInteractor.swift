import Foundation

public protocol WelcomeBusinessLogic {}
public protocol WelcomeDataStore {}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    
    private let presenter: WelcomePresentationLogic
    
    init(presenter: WelcomePresentationLogic) {
        self.presenter = presenter
    }
    
}
