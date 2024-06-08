import UIKit

public protocol LoginCPFViewActions {
    var didTapNextButton: (_ cpfText: String?) -> Void { get }
}

public protocol LoginCPFViewProtocol: ViewInitializer, KeyboardAdjustableViewProtocol {
    var actions: LoginCPFViewActions? { get set }
}

public final class LoginCPFView: CodedView, LoginCPFViewProtocol {

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
            static var margin: CGFloat = 20
        }
        
        enum NextButton {
            static var fontSize: CGFloat = 14
            static var imagePaddingMultiplier = 0.64
            static var imagePadding: CGFloat = 230
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
        label.textColor = .secondaryGray
        return label
    }()
    
    private lazy var insertCPFLabel = {
        let label = UILabel()
        label.text = String(localized: "LoginCPF.InsertCPF")
        label.font = .avenirBold(size: Metrics.InsertCPFLabel.fontSize)
        label.textColor = .primaryGray
        return label
    }()
    
    private let cpfTextfield = {
        let textField = UITextField()
        
        textField.font = .avenir(size: Metrics.CPFTextField.fontSize)
        textField.textColor = .primaryGray
        textField.tintColor = .primaryGray
        textField.becomeFirstResponder()
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var nextButton = {
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
        
        button.addTarget(
            self,
            action: #selector(didTapNextButton),
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var nextButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Public API
    public var actions: LoginCPFViewActions?
    
    public func updateNextButtonBottomConstraint(keyboardHeight: CGFloat) {
        let newBottomConstant = (keyboardHeight - safeAreaInsets.bottom) + Metrics.NextButton.margin
        updateNextButtonBottomConstraint(constant: newBottomConstant)
    }
    
    public func resetNextButtonBottomConstraint() {
        updateNextButtonBottomConstraint(constant: Metrics.NextButton.margin)
    }
    
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.configuration?.imagePadding = nextButton.frame.width * Metrics.NextButton.imagePaddingMultiplier
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
        let nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor,
            constant: -Metrics.NextButton.margin
        )
        
        self.nextButtonBottomConstraint = nextButtonBottomConstraint
        
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
            nextButtonBottomConstraint
        )
    }
    
    private func updateNextButtonBottomConstraint(constant: CGFloat) {
        nextButtonBottomConstraint?.constant = -constant
        
        UIView.animate(
            withDuration: 0
        ) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapNextButton() {
        actions?.didTapNextButton(cpfTextfield.text)
    }
}