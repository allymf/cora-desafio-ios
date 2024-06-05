import UIKit

final class LoginCPFViewController: UIViewController {
    
    let viewProtocol: LoginCPFViewProtocol
    private let interactor: LoginCPFBusinessLogic
    let router: LoginCPFRoutingLogic
    private let notificationCenter: NotificationCenter
    
    init(
        viewProtocol: LoginCPFViewProtocol = LoginCPFView(),
        interactor: LoginCPFBusinessLogic,
        router: LoginCPFRoutingLogic,
        notificationCenter: NotificationCenter = .default
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        self.router = router
        self.notificationCenter = notificationCenter
        
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
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "LoginCPF.Title")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.removeObserver(
            self, 
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        super.viewWillDisappear(animated)
    }
    
}

extension LoginCPFViewController {
    @objc
    func keyboardWillChange(_ notification: Notification) {
        let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        guard isKeyBoardShowing else {
            return viewProtocol.resetNextButtonBottomConstraint()
        }
        
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        
        viewProtocol.updateNextButtonBottomConstraint(keyboardHeight: keyboardHeight)
    }
    
}
