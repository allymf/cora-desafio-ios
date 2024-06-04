import Foundation

protocol LoginCPFBusinessLogic {}

final class LoginCPFInteractor: LoginCPFBusinessLogic {
    
    private let presenter: LoginCPFPresentationLogic
    
    init(presenter: LoginCPFPresentationLogic) {
        self.presenter = presenter
    }
    
}
