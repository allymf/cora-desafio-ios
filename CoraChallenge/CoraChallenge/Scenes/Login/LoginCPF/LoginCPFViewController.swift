import UIKit

final class LoginCPFViewController: UIViewController {
    
    let viewProtocol: LoginCPFViewProtocol
    private let interactor: LoginCPFBusinessLogic
    let router: LoginCPFRoutingLogic
    
    init(
        viewProtocol: LoginCPFViewProtocol = LoginCPFView(),
        interactor: LoginCPFBusinessLogic,
        router: LoginCPFRoutingLogic
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
        fatalError("View Controller not intended for Interface Builder")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
}
