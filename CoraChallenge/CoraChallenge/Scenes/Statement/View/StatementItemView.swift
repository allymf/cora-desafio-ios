import UIKit

final class StatementItemView: CodedView {

    // MARK: - Metrics
    enum Metrics {
        
        static var margin: CGFloat = 16
        static var smallLabelHeight: CGFloat = 20
        
        enum IconImageView {
            static var dimension: CGFloat = 24
        }
        
        enum LabelsStackView {
        }
        
        enum ValueLabel {
            static var fontSize: CGFloat = 16
            static var height: CGFloat = 24
        }
        
        enum DescriptionLabel {
            static var fontSize: CGFloat = 14
        }
        
        enum ProponentLabel {
            static var fontSize: CGFloat = 14
        }
        
        enum TimeLabel {
            static var fontSize: CGFloat = 12
            static var width: CGFloat = 60
        }
        
    }
    
    // MARK: - Subviews
    private let iconImageView = {
        let imageView = UIImageView()
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
        
        
        timeLabel.text = viewModel.hourText
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
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: Metrics.smallLabelHeight)
        )
    }
    
    func constrainProponentLabel() {
        NSLayoutConstraint.activate(
            proponentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
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
