import UIKit

protocol StatementRoutingLogic {}

final class StatementRouter: StatementRoutingLogic {
    
    weak var viewController: UIViewController?
    private let dataStore: StatementDataStore
    
    init(dataStore: StatementDataStore) {
        self.dataStore = dataStore
    }
    
}
