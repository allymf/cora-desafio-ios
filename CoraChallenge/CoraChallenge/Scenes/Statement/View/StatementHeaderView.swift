import UIKit

final class StatementHeaderView: CodedView {
    
    enum Metrics {
        static let fontSize: CGFloat = 12
        static let margin: CGFloat = 16
    }
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .avenir(size: Metrics.fontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: String? {
        get {
            titleLabel.text
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    override func addSubviews() {
        addSubview(titleLabel)
    }
    
    override func constrainSubviews() {
        NSLayoutConstraint.activate(
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.margin
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.margin
            ),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        )
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .terciaryGray
    }
    
}
