import Foundation

protocol StatementDetailsWorkingLogic {}

final class StatementDetailsWorker: StatementDetailsWorkingLogic {
    
    private let networkService: HTTPClient
    
    init(networkService: HTTPClient = NetworkService()) {
        self.networkService = networkService
    }
    
}
