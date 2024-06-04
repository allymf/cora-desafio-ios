import Foundation

struct LoginCPFSceneFactory {
    static func makeScene() -> LoginCPFViewController {
        let presenter = LoginCPFPresenter()
        let interactor = LoginCPFInteractor(presenter: presenter)
        let router = LoginCPFRouter()
        
        let viewController = LoginCPFViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.displayer = viewController
        router.viewController = viewController
        
        return viewController
    }
}
