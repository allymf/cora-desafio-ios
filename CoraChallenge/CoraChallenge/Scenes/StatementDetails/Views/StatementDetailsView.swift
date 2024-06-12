import UIKit

protocol StatementDetailsViewActions {
    var didTapShareButton: () -> Void { get }
}

protocol StatementDetailsViewProtocol: ViewInitializer {
    var actions: StatementDetailsViewActions? { get set }
}

final class StatementDetailsView: CodedView, StatementDetailsViewProtocol {
    
    enum Metrics {
        
        static let margin: CGFloat = 24
        static let bigFontSize: CGFloat = 16
        static let smallFontSize: CGFloat = 14
        
        static let interLabelSpacing: CGFloat = 4
        
        enum IconImageView {
            static let dimension: CGFloat = 24
        }
        
        enum TitleLabel {
            static let margin: CGFloat = 8
            static let height: CGFloat = 24
        }
        
        enum AttributeView {
            static let height: CGFloat = 48
        }
        
        enum ActorView {
            static let height: CGFloat = 112
        }
        
        enum DescriptionTitleLabel {
            static let height: CGFloat = 20
        }
        
        enum ShareButton {
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 64
            static let imagePadding: CGFloat = 10
            static let imagePaddingMultiplier: CGFloat = 0.3
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
        imageView.image = UIImage(named: "transference")
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
    
    private let valueAttributeView = {
        let attributeView = StatementAttributeView()
        attributeView.translatesAutoresizingMaskIntoConstraints = false
        return attributeView
    }()
    
    private let dateAttributeView = {
        let attributeView = StatementAttributeView()
        attributeView.translatesAutoresizingMaskIntoConstraints = false
        return attributeView
    }()
    
    
    private let senderView = {
        let actorView = StatementItemActorView()
        actorView.translatesAutoresizingMaskIntoConstraints = false
        return actorView
    }()
    
    private let receiverView = {
        let actorView = StatementItemActorView()
        actorView.translatesAutoresizingMaskIntoConstraints = false
        return actorView
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
        label.text = "Como Quiabo cru\nComo Quiabo cru\nComo Quiabo cru\nComo Quiabo cru\nComo Quiabo cru\n"
        label.numberOfLines = .zero
        label.font = .avenir(size: Metrics.smallFontSize)
        label.textColor = .secondaryGray
        label.numberOfLines = 0
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

    var actions: StatementDetailsViewActions?
    
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
        contentView.addSubviews(
            iconImageView,
            titleLabel,
            valueAttributeView,
            dateAttributeView,
            senderView,
            receiverView,
            descriptionTitleLabel,
            descriptionLabel
        )
    }

    override func constrainSubviews() {
        constrainShareButton()
        constrainScrollView()
        constrainContentView()
        constrainIconImageView()
        constrainTitleLabel()
        constrainValueAttributeView()
        constrainDateAttributeView()
        constrainSenderView()
        constrainReceiverView()
        constrainDescriptionTitleLabel()
        constrainDescriptionLabel()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
    
    @objc
    private func didTapShareButton() {
        actions?.didTapShareButton()
    }
    
}

// MARK: - Layout Methods
private extension StatementDetailsView {
    func constrainScrollView() {
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
    
    func constrainContentView() {
        NSLayoutConstraint.activate(
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        )
    }
    
    func constrainIconImageView() {
        NSLayoutConstraint.activate(
            iconImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.margin
            ),
            iconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            iconImageView.widthAnchor.constraint(equalToConstant: Metrics.IconImageView.dimension),
            iconImageView.heightAnchor.constraint(equalToConstant: Metrics.IconImageView.dimension)
        )
    }
    
    func constrainTitleLabel() {
        NSLayoutConstraint.activate(
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Metrics.TitleLabel.margin
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: Metrics.TitleLabel.height)
        )
    }
    
    func constrainValueAttributeView() {
        NSLayoutConstraint.activate(
            valueAttributeView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.margin
            ),
            valueAttributeView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            valueAttributeView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            valueAttributeView.heightAnchor.constraint(equalToConstant: Metrics.AttributeView.height)
        )
        
    }
    
    func constrainDateAttributeView() {
        NSLayoutConstraint.activate(
            dateAttributeView.topAnchor.constraint(
                equalTo: valueAttributeView.bottomAnchor,
                constant: Metrics.margin
            ),
            dateAttributeView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            dateAttributeView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            dateAttributeView.heightAnchor.constraint(equalToConstant: Metrics.AttributeView.height)
        )
    }
    
    func constrainSenderView() {
        NSLayoutConstraint.activate(
            senderView.topAnchor.constraint(
                equalTo: dateAttributeView.bottomAnchor,
                constant: Metrics.margin
            ),
            senderView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            senderView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            senderView.heightAnchor.constraint(equalToConstant: Metrics.ActorView.height)
        )
    }
    
    func constrainReceiverView() {
        NSLayoutConstraint.activate(
            receiverView.topAnchor.constraint(
                equalTo: senderView.bottomAnchor,
                constant: Metrics.margin
            ),
            receiverView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            receiverView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            
            receiverView.heightAnchor.constraint(equalToConstant: Metrics.ActorView.height)
        )
    }
    
    func constrainDescriptionTitleLabel() {
        NSLayoutConstraint.activate(
            descriptionTitleLabel.topAnchor.constraint(
                equalTo: receiverView.bottomAnchor,
                constant: Metrics.margin
            ),
            descriptionTitleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            descriptionTitleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: Metrics.DescriptionTitleLabel.height)
        )
    }
    
    func constrainDescriptionLabel() {
        NSLayoutConstraint.activate(
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionTitleLabel.bottomAnchor,
                constant: Metrics.interLabelSpacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.margin
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.margin
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.margin
            )
        )
    }
        
    func constrainShareButton() {
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
            shareButton.heightAnchor.constraint(equalToConstant: Metrics.ShareButton.height)
        )
    }
}