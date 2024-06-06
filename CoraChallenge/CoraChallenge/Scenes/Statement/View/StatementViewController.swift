import UIKit

final class StatementViewController: UIViewController {
    
    let viewProtocol: StatementViewProtocol
    private let interactor: StatementBusinessLogic & StatementDataStore
    let router: StatementRoutingLogic
    
    init(
        viewProtocol: StatementViewProtocol = StatementView(),
        interactor: StatementBusinessLogic & StatementDataStore,
        router: StatementRoutingLogic
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
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "Statement.Title")
        viewProtocol.setupTableView(with: self)
        
        let downloadIcon = UIImage(named: "signOut")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: downloadIcon,
            style: .plain,
            target: self,
            action: #selector(didTapDownloadBarButtonItem)
        )
    }
    
    @objc
    private func didTapDownloadBarButtonItem() {}
}
