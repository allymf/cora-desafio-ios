import Foundation

struct StatementDetailsSceneFactory {
    static func makeScene(id: String) -> StatementDetailsViewController {
        let presenter = StatementDetailsPresenter()
        let interactor = StatementDetailsInteractor(
            presenter: presenter,
            itemId: id
        )
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
