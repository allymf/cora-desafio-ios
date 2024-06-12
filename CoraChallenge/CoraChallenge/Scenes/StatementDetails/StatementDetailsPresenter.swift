import Foundation

protocol StatementDetailsPresentationLogic {}

final class StatementDetailsPresenter: StatementDetailsPresentationLogic {
    
    weak var displayer: StatementDetailsDisplayLogic?
    
}
