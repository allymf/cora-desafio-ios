import Foundation



protocol StatementDetailsWorkingLogic {
    func getStatementDetails(
        parameters: StatementDetailsModels.StatementDetailsParameters,
        completionHandler: @escaping (Result<StatementDetailsResponse, NetworkLayerError>) -> Void
    )
    
    func cancelCurrentTask()
}

final class StatementDetailsWorker: StatementDetailsWorkingLogic {
    
    
    private let networkService: HTTPClient
    
    init(networkService: HTTPClient = NetworkService()) {
        self.networkService = networkService
    }
    
    func getStatementDetails(
        parameters: StatementDetailsModels.StatementDetailsParameters,
        completionHandler: @escaping (Result<StatementDetailsResponse, NetworkLayerError>) -> Void
    ) {
        let endPoint = StatementDetailsEndpoint.statementItemDetails(
            id: parameters.id,
            token: parameters.token
        )
        networkService.request(
            endpoint: endPoint,
            responseType: StatementDetailsResponse.self, 
            completionHandler: completionHandler
        )
    }
    
    func cancelCurrentTask() {
        networkService.cancelCurrentTask()
    }
    
}
