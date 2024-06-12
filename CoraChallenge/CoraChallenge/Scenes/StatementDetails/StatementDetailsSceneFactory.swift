import Foundation

struct StatementDetailsSceneFactory {
    static func makeScene() -> StatementDetailsViewController {
        let presenter = StatementDetailsPresenter()
        let interactor = StatementDetailsInteractor(presenter: presenter)
        let router = StatementDetailsRouter()
        
        let viewController = StatementDetailsViewController(
            interactor: interactor, 
            router: router
        )
        
        router.viewController = viewController
        presenter.displayer = viewController
        
        return viewController
    }
}
