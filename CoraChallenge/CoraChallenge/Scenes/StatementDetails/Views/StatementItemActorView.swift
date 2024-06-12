import UIKit

final class StatementItemActorView: CodedView {
    
    enum Metrics {
        static let bigFontSize: CGFloat = 16
        static let smallFontSize: CGFloat = 14
        static let interLabelSpacing: CGFloat = 4
    }
    
    // MARK: - Subviews
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameLabel = {
        let label = UILabel()
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let documentLabel = {
        let label = UILabel()
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bankNameLabel = {
        let label = UILabel()
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bankInformationLabel = {
        let label = UILabel()
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    var document: String? {
        get { documentLabel.text }
        set { documentLabel.text = newValue }
    }
    
    var bankName: String? {
        get { bankNameLabel.text }
        set { bankNameLabel.text = newValue }
    }
    
    var bankInformation: String? {
        get { bankInformationLabel.text }
        set { bankInformationLabel.text = newValue }
    }
    
    
    // MARK: - CodedView life cycle
    override func addSubviews() {
        addSubviews(
            titleLabel,
            nameLabel,
            documentLabel,
            bankNameLabel,
            bankInformationLabel
        )
    }
    
    override func constrainSubviews() {
        constrainTitleLabel()
        constrainNameLabel()
        constrainDocumentLabel()
        constrainBankNameLabel()
        constrainBankInformationLabel()
    }
    
    override func configureAdditionalSettings() {}
    
}

private extension StatementItemActorView {
    func constrainTitleLabel() {
        NSLayoutConstraint.activate(
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        )
    }
    
    func constrainNameLabel() {
        NSLayoutConstraint.activate(
            nameLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        )
    }
    
    func constrainDocumentLabel() {
        NSLayoutConstraint.activate(
            documentLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            documentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            documentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        )
    }
    
    func constrainBankNameLabel() {
        NSLayoutConstraint.activate(
            bankNameLabel.topAnchor.constraint(
                equalTo: documentLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            bankNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bankNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        )
    }
    
    func constrainBankInformationLabel() {
        NSLayoutConstraint.activate(
            bankInformationLabel.topAnchor.constraint(
                equalTo: bankNameLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            bankInformationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bankInformationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        )
    }
}
