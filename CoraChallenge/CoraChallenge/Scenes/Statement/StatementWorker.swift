import Foundation

protocol StatementWorkingLogic {
    
    func getStatement(
        token: String,
        completionHandler: @escaping (Result<StatementResponse, NetworkLayerError>) -> Void
    )
    func cancelCurrentTask()
    
}

final class StatementWorker: StatementWorkingLogic {
    
    
    private let networkService: HTTPClient
    
    init(networkService: HTTPClient = NetworkService()) {
        self.networkService = networkService
    }

    func getStatement(
        token: String,
        completionHandler: @escaping (Result<StatementResponse, NetworkLayerError>) -> Void
    ) {
        networkService.request(
            endpoint: StatementEndpoint.statement(token: token),
            responseType: StatementResponse.self,
            completionHandler: completionHandler
        )
    }
    
    func cancelCurrentTask() {
        networkService.cancelCurrentTask()
    }
    
    
}
