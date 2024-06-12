import UIKit

final class StatementItemView: CodedView {
    
    // MARK: - Metrics
    enum Metrics {
        
        static let margin: CGFloat = 24
        static let topMargin: CGFloat = 2
        static let smallLabelHeight: CGFloat = 18
        
        enum IconImageView {
            static let dimension: CGFloat = 24
        }
        
        enum ValueLabel {
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 20
        }
        
        enum DescriptionLabel {
            static let fontSize: CGFloat = 14
        }
        
        enum ProponentLabel {
            static let fontSize: CGFloat = 14
        }
        
        enum TimeLabel {
            static let fontSize: CGFloat = 12
            static let width: CGFloat = 60
        }
        
    }
    
    // MARK: - Subviews
    private let iconImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .primaryGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var valueLabel = {
        let label = UILabel()
        label.font = .avenirBold(size: Metrics.ValueLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .avenir(size: Metrics.DescriptionLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var proponentLabel = {
        let label = UILabel()
        label.font = .avenir(size: Metrics.ProponentLabel.fontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .avenir(size: Metrics.ValueLabel.fontSize)
        label.textColor = .secondaryGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            iconImageView,
            valueLabel,
            descriptionLabel,
            proponentLabel,
            timeLabel
        )
    }
    
    override func constrainSubviews() {
        constrainIconImageView()
        constrainValueLabel()
        constrainDescriptionLabel()
        constrainProponentLabel()
        constrainTimeLabel()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
    
    // MARK: - Public API
    func setup(with viewModel: StatementModels.StatementViewModel.Item) {
        valueLabel.text = viewModel.currencyAmount
        descriptionLabel.text = viewModel.label
        proponentLabel.text = viewModel.name
        timeLabel.text = viewModel.hourText
        
        let icon = getIcon(for: viewModel.entry)
        iconImageView.image = icon
        
        let tintColor = getTintColor(for: viewModel.entry)
        valueLabel.textColor = tintColor
        descriptionLabel.textColor = tintColor
    }
    
    private func getIcon(for entryType: StatementModels.StatementViewModel.Entry) -> UIImage {
        switch entryType {
        case .credit:
            return UIImage(named: "deposit") ?? UIImage()
        case .debit:
            return UIImage(named: "transference") ?? UIImage()
        case .none:
            return UIImage()
        }
    }
    
    private func getTintColor(for entryType: StatementModels.StatementViewModel.Entry) -> UIColor {
        switch entryType {
        case .credit:
            return .incomeBlue
        default:
            return .primaryGray
        }
    }
    
}

private extension StatementItemView {
    
    func constrainIconImageView() {
        NSLayoutConstraint.activate(
            iconImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.margin
            ),
            iconImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.margin
            ),
            iconImageView.widthAnchor.constraint(equalToConstant: Metrics.IconImageView.dimension),
            iconImageView.heightAnchor.constraint(equalToConstant: Metrics.IconImageView.dimension)
        )
    }
    
    func constrainValueLabel() {
        NSLayoutConstraint.activate(
            valueLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.margin
            ),
            valueLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Metrics.margin
            ),
            valueLabel.trailingAnchor.constraint(
                equalTo: timeLabel.leadingAnchor
            ),
            valueLabel.heightAnchor.constraint(equalToConstant: Metrics.ValueLabel.height)
        )
    }
    
    func constrainDescriptionLabel() {
        NSLayoutConstraint.activate(
            descriptionLabel.topAnchor.constraint(
                equalTo: valueLabel.bottomAnchor,
                constant: Metrics.topMargin
            ),
            descriptionLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: Metrics.smallLabelHeight)
        )
    }
    
    func constrainProponentLabel() {
        NSLayoutConstraint.activate(
            proponentLabel.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.topMargin
            ),
            proponentLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            proponentLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            proponentLabel.heightAnchor.constraint(equalToConstant: Metrics.smallLabelHeight)
        )
    }    
    
    func constrainTimeLabel() {
        NSLayoutConstraint.activate(
            timeLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.margin
            ),
            timeLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: Metrics.smallLabelHeight),
            timeLabel.widthAnchor.constraint(equalToConstant: Metrics.TimeLabel.width)
        )
    }
    
}
