import Foundation

protocol LoginPasswordDataStore {
    var cpfText: String { get }
}

protocol LoginPasswordBusinessLogic {}
    
final class LoginPasswordInteractor: LoginPasswordBusinessLogic, LoginPasswordDataStore {
    private let presenter: LoginPasswordPresentationLogic
    private let worker: LoginPasswordWorkingLogic
    
    // MARK: - DataStore
    private(set) var cpfText: String
    
    init(
        presenter: LoginPasswordPresentationLogic,
        worker: LoginPasswordWorkingLogic,
        cpfText: String
    ) {
        self.presenter = presenter
        self.worker = worker
        self.cpfText = cpfText
    }
    
}
