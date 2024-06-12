import Foundation

struct LoginPasswordSceneFactory {
    static func makeScene(cpfText: String) -> LoginPasswordViewController {
        let presenter = LoginPasswordPresenter()
        let interactor = LoginPasswordInteractor(
            presenter: presenter,
            cpfText: cpfText
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
