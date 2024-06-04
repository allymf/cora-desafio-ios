import UIKit

protocol LoginCPFViewProtocol: ViewInitializer {}

final class LoginCPFView: CodedView, LoginCPFViewProtocol {
    
    enum Metrics {
        
        enum LabelsStackView {
            static var spacing: CGFloat = 8
            static var topMargin: CGFloat = 8
            static var margin: CGFloat = 20
        }
        
        enum WelcomeLabel {
            static var fontSize: CGFloat = 16
        }
        
        enum InsertCPFLabel {
            static var fontSize: CGFloat = 22
        }
        
        enum CPFTextField {
            static var fontSize: CGFloat = 22
            static var height: CGFloat = 32
            static var topMargin: CGFloat = 32
            static var margin: CGFloat = 18
        }
        
        enum NextButton {
            static var fontSize: CGFloat = 14
            static var imagePadding: CGFloat = 150
            static var height: CGFloat = 48
            static var margin: CGFloat = 16
        }
        
    }
    
    // MARK: - Subviews
    private lazy var labelsStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(insertCPFLabel)
        
        stackView.spacing = Metrics.LabelsStackView.spacing
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var welcomeLabel = {
        let label = UILabel()
        label.text = String(localized: "LoginCPF.Welcome")
        label.font = .avenir(size: Metrics.WelcomeLabel.fontSize)
        label.textColor = .secondaryText
        return label
    }()
    
    private lazy var insertCPFLabel = {
        let label = UILabel()
        label.text = String(localized: "LoginCPF.InsertCPF")
        label.font = .avenirBold(size: Metrics.InsertCPFLabel.fontSize)
        label.textColor = .primaryText
        return label
    }()
    
    private let cpfTextfield = {
        let textField = UITextField()
        
        textField.font = .avenir(size: Metrics.CPFTextField.fontSize)
        textField.textColor = .primaryText
        textField.tintColor = .primaryText
        textField.becomeFirstResponder()
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let nextButton = {
        let button = CoraButton()
        
        var configuration = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = .avenirBold(size: Metrics.NextButton.fontSize)
        
        let attributedTitle = AttributedString.init(
            String(localized: "LoginCPF.NextButton.Title"),
            attributes: container
        )
        
        configuration.attributedTitle = attributedTitle
        configuration.image = UIImage(named: "arrowRight")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = Metrics.NextButton.imagePadding
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .mainPink
        
        button.configuration = configuration
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            labelsStackView,
            cpfTextfield,
            nextButton
        )
    }
    
    override func constrainSubviews() {
        constrainLabelsStackView()
        constrainCPFTextField()
        constrainNextButton()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
    
    private func constrainLabelsStackView() {
        NSLayoutConstraint.activate(
            labelsStackView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Metrics.LabelsStackView.topMargin
            ),
            labelsStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.LabelsStackView.margin
            ),
            labelsStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.LabelsStackView.margin)
        )
    }
    
    private func constrainCPFTextField() {
        NSLayoutConstraint.activate(
            cpfTextfield.topAnchor.constraint(
                equalTo: labelsStackView.bottomAnchor,
                constant: Metrics.CPFTextField.topMargin
            ),
            cpfTextfield.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.CPFTextField.margin
            ),
            cpfTextfield.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.CPFTextField.margin
            ),
            cpfTextfield.heightAnchor.constraint(equalToConstant: Metrics.CPFTextField.height)
        )
    }
    
    private func constrainNextButton() {
        NSLayoutConstraint.activate(
            nextButton.heightAnchor.constraint(equalToConstant: Metrics.NextButton.height),
            nextButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.NextButton.margin
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.NextButton.margin
            ),
            nextButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -Metrics.NextButton.margin
            )
        )
    }
    
}
