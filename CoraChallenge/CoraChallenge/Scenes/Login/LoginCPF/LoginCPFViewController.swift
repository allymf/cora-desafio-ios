import UIKit

final class LoginCPFViewController: KeyboardAdjustableViewController {
    
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
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("View Controller not intended for Interface Builder")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "LoginCPF.Title")
        viewProtocol.actions = LoginCPFModels.Actions(didTapNextButton: didTapNextButton)
    }
    
    override func keyboardIsShowing(keyboardHeight: CGFloat) {
        viewProtocol.updateNextButtonBottomConstraint(keyboardHeight: keyboardHeight)
    }
    
    override func keyboardIsHiding() {
        viewProtocol.resetNextButtonBottomConstraint()
    }
    
}

extension LoginCPFViewController {
    func didTapNextButton(_ cpfText: String?) {
        interactor.didTapNextButton(request: .init(cpfText: cpfText))
    }
}
