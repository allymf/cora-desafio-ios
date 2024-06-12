import UIKit

protocol StatementDetailsViewProtocol: ViewInitializer {}

final class StatementDetailsView: CodedView, StatementDetailsViewProtocol {

    // MARK: - CodedView Life Cycle
    override func addSubviews() {}

    override func constrainSubviews() {}
    
    override func configureAdditionalSettings() {}
    
}
