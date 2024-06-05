import Foundation

public protocol LoginPasswordPresentationLogic {}

final class LoginPasswordPresenter: LoginPasswordPresentationLogic {
    
    weak var displayer: LoginPasswordDisplayLogic?
    
}
