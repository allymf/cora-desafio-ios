import UIKit

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
    
    static func makeSceneInNavigationController() -> UINavigationController {
        let viewController = makeScene()
        return UINavigationController(rootViewController: viewController)
    }
}
