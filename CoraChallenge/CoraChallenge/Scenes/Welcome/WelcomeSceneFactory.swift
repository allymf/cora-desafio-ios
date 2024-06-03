import Foundation

public struct WelcomeSceneFactory {
    static func makeScene() -> WelcomeViewController {
        let viewController = WelcomeViewController()
        
        let presenter = WelcomePresenter(displayer: viewController)
        let interactor = WelcomeInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        
        return viewController
    }
}
