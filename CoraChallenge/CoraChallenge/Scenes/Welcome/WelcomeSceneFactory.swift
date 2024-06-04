import Foundation

public struct WelcomeSceneFactory {
    static func makeScene() -> WelcomeViewController {
        let presenter = WelcomePresenter()
        let interactor = WelcomeInteractor(presenter: presenter)
        let router = WelcomeRouter()
        
        let viewController = WelcomeViewController(interactor: interactor, router: router)
        
        presenter.displayer = viewController
        router.viewController = viewController
        
        return viewController
    }
}
