import Foundation

protocol LoginPasswordWorkingLogic {
    
    func login(
        loginParameters: LoginPasswordModels.LoginParameters,
        completionHandler: @escaping (Result<LoginResponse, NetworkLayerError>) -> Void
    )
    func cancelCurrentTask()
}

final class LoginPasswordWorker: LoginPasswordWorkingLogic {
    
    private let networkService: HTTPClient
    
    init(networkService: HTTPClient = NetworkService()) {
        self.networkService = networkService
    }
    
    func login(
        loginParameters: LoginPasswordModels.LoginParameters,
        completionHandler: @escaping (Result<LoginResponse, NetworkLayerError>) -> Void
    ) {
        let endpoint = LoginEndpoint.login(
            cpf: loginParameters.cpf,
            password: loginParameters.password
        )
        networkService.request(
            endpoint: endpoint, 
            responseType: LoginResponse.self,
            completionHandler: completionHandler
        )
    }
    
    func cancelCurrentTask() {
        networkService.cancelCurrentTask()
    }
    
}
