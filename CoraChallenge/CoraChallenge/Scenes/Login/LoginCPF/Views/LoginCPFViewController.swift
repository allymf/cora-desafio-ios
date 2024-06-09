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
        navigationItem.backButtonTitle = String()
        viewProtocol.actions = LoginCPFModels.Actions(
            didTapNextButton: didTapNextButton,
            cpfTextDidChange: cpfTextDidChange
        )
        viewProtocol.setCPFTextFieldDelegate(self)
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
        interactor.didTapNextButton()
    }
    
    func cpfTextDidChange(_ cpfText: String?) {
        interactor.validateCPF(request: .init(cpfText: cpfText))
    }
}

extension LoginCPFViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        guard range.length == 0 else { return true }
        
        switch range.location {
        case 3,7:
            textField.text?.append(".")
        case 11:
            textField.text?.append("-")
        default:
            break
        }
        
        let newTextLength = (textField.text ?? "").count
        guard newTextLength <= 13 else { return false }
        
        return true
    }
    
}
