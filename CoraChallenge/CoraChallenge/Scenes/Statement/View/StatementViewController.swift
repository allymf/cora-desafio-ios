import UIKit

final class StatementViewController: CoraViewController {
    
    let viewProtocol: StatementViewProtocol
    let interactor: StatementBusinessLogic
    let router: StatementRoutingLogic
    
    var viewModel: StatementModels.StatementViewModel?
    
    private lazy var rightBarButtonItem = {
        let icon = UIImage(named: "signOut")
        return UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(didTapDownloadBarButtonItem)
        )
    }()
    
    init(
        viewProtocol: StatementViewProtocol = StatementView(),
        interactor: StatementBusinessLogic,
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
        viewProtocol.actions = StatementModels.Action(didPullToRefresh: didPullToRefresh)
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadStatement()
    }
    
    @objc
    private func didTapDownloadBarButtonItem() {}
    
    @objc
    private func didPullToRefresh() {
        interactor.loadStatement()
    }
    
}
