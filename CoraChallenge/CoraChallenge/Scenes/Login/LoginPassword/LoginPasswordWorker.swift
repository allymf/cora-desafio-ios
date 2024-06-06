import Foundation

protocol LoginParametersProtocol {
    var cpf: String { get }
    var password: String { get }
}

protocol LoginPasswordWorkingLogic {
    
    func login(
        loginParameters: LoginParametersProtocol,
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
        loginParameters: LoginParametersProtocol,
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
