import Foundation

struct LoginPasswordSceneFactory {
    static func makeScene() -> LoginPasswordViewController {
        let presenter = LoginPasswordPresenter()
        let worker = LoginPasswordWorker()
        let interactor = LoginPasswordInteractor(
            presenter: presenter,
            worker: worker
        )
        let router = LoginPasswordRouter()
        
        let viewController = LoginPasswordViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.displayer = viewController
        router.viewController = viewController
        
        return viewController
    }
}
