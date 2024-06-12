import UIKit

protocol StatementDetailsViewProtocol: ViewInitializer {}

final class StatementDetailsView: CodedView, StatementDetailsViewProtocol {
    
    enum Metrics {
        
        static let margin: CGFloat = 24
        static let bigFontSize: CGFloat = 16
        static let smallFontSize: CGFloat = 14
        
        enum ShareButton {
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 64
            static let imagePadding: CGFloat = 10
            static let imagePaddingMultiplier: CGFloat = 0.65
        }
        
    }
    
    // MARK: - Subviews
    private let scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = .primaryGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "Transferência Enviada"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let valueTitleLabel = {
        let label = UILabel()
        label.text = "Valor"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let valueLabel = {
        let label = UILabel()
        label.text = "R$ 154,00"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateTitleLabel = {
        let label = UILabel()
        label.text = "Data"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "Hoje - 12/10/2019"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let fromLabel = {
        let label = UILabel()
        label.text = "De"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let senderNameLabel = {
        let label = UILabel()
        label.text = "Dev"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let senderDocumentLabel = {
        let label = UILabel()
        label.text = "CPF 132.456.789-10"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let senderBankNameLabel = {
        let label = UILabel()
        label.text = "Banco Cora"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let senderBankInformationLabel = {
        let label = UILabel()
        label.text = "Agencia 1 conta 123123"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let toLabel = {
        let label = UILabel()
        label.text = "Para"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let receiverNameLabel = {
        let label = UILabel()
        label.text = "Designer"
        
        label.font = .avenirBold(size: Metrics.bigFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let receiverDocumentLabel = {
        let label = UILabel()
        label.text = "CPF 132.456.789-10"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let receiverBankNameLabel = {
        let label = UILabel()
        label.text = "Banco Cora"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let receiverBankInformationLabel = {
        let label = UILabel()
        label.text = "Agencia 1 conta 123123"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private let descriptionTitleLabel = {
        let label = UILabel()
        label.text = "Descrição"
        
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .primaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "Como Quiabo cru"
        label.numberOfLines = .zero
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var shareButton = {
        let button = CoraButton()
        
        var configuration = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = .avenirBold(size: Metrics.ShareButton.fontSize)
        
        let attributedTitle = AttributedString.init(
            String(localized: "StatementDetails.ShareButton.Title"),
            attributes: container
        )
        
        configuration.attributedTitle = attributedTitle
        configuration.image = UIImage(named: "share")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = Metrics.ShareButton.imagePadding
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .mainPink
        
        button.configuration = configuration
        button.isEnabled = false
        
        button.addTarget(
            self,
            action: #selector(didTapShareButton),
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    public override func layoutSubviews() {
        super.layoutSubviews()
        shareButton.configuration?.imagePadding = shareButton.frame.width * Metrics.ShareButton.imagePaddingMultiplier
    }
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            scrollView,
            shareButton
        )
        scrollView.addSubview(contentView)
    }

    override func constrainSubviews() {
        constrainShareButton()
        constrainScrollView()
        constrainContentView()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
    
    private func constrainScrollView() {
        NSLayoutConstraint.activate(
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: shareButton.topAnchor,
                constant: -Metrics.margin
            )
        )
    }
    
    private func constrainContentView() {
        NSLayoutConstraint.activate(
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        )
    }
    
    private func constrainShareButton() {
        NSLayoutConstraint.activate(
            shareButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.margin
            ),
            shareButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.margin
            ),
            shareButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -Metrics.margin
            ),
            shareButton.heightAnchor.constraint(equalToConstant: -Metrics.margin)
        )
    }
    
    @objc
    private func didTapShareButton() {}
    
}
