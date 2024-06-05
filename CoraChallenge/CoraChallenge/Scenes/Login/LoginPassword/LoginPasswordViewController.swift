import UIKit

final class LoginPasswordViewController: KeyboardAdjustableViewController {

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
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("View Controller not intended for Interface Builder.")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "LoginCPF.Title")
    }
    
    override func keyboardIsShowing(keyboardHeight: CGFloat) {
        viewProtocol.updateNextButtonBottomConstraint(keyboardHeight: keyboardHeight)
    }
    
    override func keyboardIsHiding() {
        viewProtocol.resetNextButtonBottomConstraint()
    }
    
}
