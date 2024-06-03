import UIKit

final class WelcomeViewController: UIViewController {
    var interactor: WelcomeBusinessLogic?
    
    override func loadView() {
        view = WelcomeView()
    }
}
