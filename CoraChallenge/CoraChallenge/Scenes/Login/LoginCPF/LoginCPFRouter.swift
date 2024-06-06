import UIKit

protocol LoginCPFRoutingLogic {
    func routeToLoginPassword()
}

final class LoginCPFRouter: LoginCPFRoutingLogic {
    
    weak var viewController: UIViewController?
    private let dataStore: LoginCPFDataStore
    
    init(dataStore: LoginCPFDataStore) {
        self.dataStore = dataStore
    }
    
    func routeToLoginPassword() {
        let loginPasswordViewController = LoginPasswordSceneFactory.makeScene(cpfText: dataStore.cpfText)
        
        viewController?.show(
            loginPasswordViewController,
            sender: viewController
        )
    }
    
}
