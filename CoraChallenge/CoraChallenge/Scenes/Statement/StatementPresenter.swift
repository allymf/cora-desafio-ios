import Foundation

protocol StatementPresentationLogic {}

final class StatementPresenter: StatementPresentationLogic {
    
    weak var displayer: StatementDisplayLogic?
    
}
