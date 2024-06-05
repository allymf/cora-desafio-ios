import Foundation

struct StatementSceneFactory {
    static func makeScene() -> StatementViewController {
        let presenter = StatementPresenter()
        let worker = StatementWorker()
        let interactor = StatementInteractor(
            presenter: presenter,
            worker: worker
        )
        let router = StatementRouter(dataStore: interactor)
        
        let viewController = StatementViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.displayer = viewController
        router.viewController = viewController
        
        return viewController
    }
}
