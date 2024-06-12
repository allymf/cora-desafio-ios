import UIKit

protocol StatementDetailsRoutingLogic {
    func routeToShareReceipt(receiptImage: UIImage)
}

final class StatementDetailsRouter: StatementDetailsRoutingLogic {
    
    weak var viewController: UIViewController?
    
    func routeToShareReceipt(receiptImage: UIImage) {
        let activityViewController = UIActivityViewController(
            activityItems: [receiptImage],
            applicationActivities: nil
        )
        viewController?.present(
            activityViewController,
            animated: true
        )
    }
    
}
