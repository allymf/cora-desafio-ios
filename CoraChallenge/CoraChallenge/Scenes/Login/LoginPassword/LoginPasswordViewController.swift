import UIKit

final class LoginPasswordViewController: UIViewController {

    let viewProtocol: LoginPasswordViewProtocol
    private let interactor: LoginPasswordBusinessLogic
    let router: LoginPasswordRoutingLogic
    
    init(
        viewProtocol: LoginPasswordViewProtocol = LoginPasswordView(),
        interactor: LoginPasswordBusinessLogic,
        router: LoginPasswordRoutingLogic
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        self.router = router
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("View Controller not intended for Interface Builder.")
    }
    
}
