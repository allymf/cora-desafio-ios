import UIKit

final class StatementDetailsViewController: CoraViewController {

    let viewProtocol: StatementDetailsViewProtocol
    private let interactor: StatementDetailsBusinessLogic
    let router: StatementDetailsRoutingLogic
    
    init(
        viewProtocol: StatementDetailsViewProtocol = StatementDetailsView(),
        interactor: StatementDetailsBusinessLogic,
        router: StatementDetailsRoutingLogic
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
        interactor.didLoad()
    }

}
