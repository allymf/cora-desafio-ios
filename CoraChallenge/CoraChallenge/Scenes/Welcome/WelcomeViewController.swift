import UIKit

final class WelcomeViewController: UIViewController {
    
    let viewProtocol: WelcomeViewProtocol
    private let interactor: WelcomeBusinessLogic
    let router: WelcomeRoutingLogic
    
    init(
        viewProtocol: WelcomeViewProtocol = WelcomeView(),
        interactor: WelcomeBusinessLogic,
        router: WelcomeRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        self.viewProtocol = viewProtocol
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.viewProtocol.actions = WelcomeModels.Actions(didTapLoginButton: didTapLoginButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ViewController not intended for Interface Builder")
    }
    
    override func loadView() {
        self.view = viewProtocol.concreteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = String()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            true,
            animated: false
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(
            false,
            animated: false
        )
    }
    
}

extension WelcomeViewController {
    func didTapLoginButton() {
        interactor.didTapLogin()
    }
}
