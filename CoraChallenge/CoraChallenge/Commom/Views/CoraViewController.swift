import UIKit

open class CoraViewController: UIViewController {
    
    func makeErrorAlert(
        title: String = String(localized: "ErrorAlert.title"),
        message: String = String(localized: "GenericErrorMessage")
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: String(localized: "Dismiss"),
            style: .default) { _ in
                alert.dismiss(animated: true)
            }
        
        alert.addAction(okAction)
        
        return alert
    }
    
}

