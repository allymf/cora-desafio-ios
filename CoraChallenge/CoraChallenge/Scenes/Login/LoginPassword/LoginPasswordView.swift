import UIKit

protocol LoginPasswordViewProtocol: ViewInitializer {}

final class LoginPasswordView: CodedView, LoginPasswordViewProtocol {
    
    // MARK: - Metrics
    enum Metrics {
        
        static var margin: CGFloat = 16
        
        enum InsertPasswordLabel {
            static var fontSize: CGFloat = 22
        }
        
        enum PasswordStackView {
            static var spacing: CGFloat = 8
            static var topMargin: CGFloat = 32
            static var height: CGFloat = 32
        }
        
        enum PasswordTextField {
            static var fontSize: CGFloat = 22
        }
        
        enum PasswordToggleButton {
            static var width: CGFloat = 48
        }
        
        enum ForgotPassword {
            static var widthMultiplier: CGFloat = 0.35
            static var height: CGFloat = 48
        }
        
        enum NextButton {
            static var fontSize: CGFloat = 14
            static var imagePadding: CGFloat = 8
            static var imagePaddingMultiplier: CGFloat = 0.65
            static var height: CGFloat = 48
        }
        
    }
    
    // MARK: - Subviews
    private let insertPasswordLabel = {
        let label = UILabel()
        
        label.text = String(localized: "LoginPassword.InsertLabel.Title")
        label.font = .avenirBold(size: 22)
        label.textColor = .primaryGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var passwordStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordToggleButton)
        
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var passwordTextField = {
        let textField = UITextField()
        
        textField.isSecureTextEntry = true
        textField.font = .avenirBold(size: Metrics.PasswordTextField.fontSize)
        textField.tintColor = .primaryGray
        
        return textField
    }()
    
    private lazy var passwordToggleButton = {
        let button = UIButton()
        
        let buttonIcon = UIImage(named: "eyeHidden")
        button.setImage(
            buttonIcon,
            for: .normal
        )
        button.tintColor = .mainPink
        
        button.addTarget(
            self,
            action: #selector(didTapPasswordToggleButton),
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let forgotPasswordButton = {
        let button = CoraButton(style: .defaultWhite)
        
        button.setTitle(
            String(localized: "LoginPassword.ForgotPasswordButton.Title"),
            for: .normal
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    public override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.configuration?.imagePadding = nextButton.frame.width * Metrics.NextButton.imagePaddingMultiplier
    }
    
    // MARK: - CodedView Life Cycle
    override func addSubviews() {
        addSubviews(
            insertPasswordLabel,
            passwordStackView,
            forgotPasswordButton,
            nextButton
        )
    }
    
    override func constrainSubviews() {
        constrainInsertPasswordLabel()
        constrainPasswordStackView()
        constrainPasswordToggleButton()
        constrainForgotPasswordButton()
        constrainNextButton()
    }
    
    override func configureAdditionalSettings() {
        backgroundColor = .white
    }
    
    @objc
    private func didTapPasswordToggleButton() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    private func constrainInsertPasswordLabel() {
        NSLayoutConstraint.activate(
            insertPasswordLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Metrics.margin
            ),
            insertPasswordLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.margin
            ),
            insertPasswordLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.margin
            )
        )
    }
    
    private func constrainPasswordStackView() {
        NSLayoutConstraint.activate(
            passwordStackView.topAnchor.constraint(
                equalTo: insertPasswordLabel.bottomAnchor,
                constant: Metrics.PasswordStackView.topMargin
            ),
            passwordStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.margin
            ),
            passwordStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.margin
            ),
            passwordStackView.heightAnchor.constraint(equalToConstant: Metrics.PasswordStackView.height)
        )
    }
    
    private func constrainPasswordToggleButton() {
        NSLayoutConstraint.activate(
            passwordToggleButton.widthAnchor.constraint(equalToConstant: Metrics.PasswordToggleButton.width)
        )
    }
    
    private func constrainForgotPasswordButton() {
        NSLayoutConstraint.activate(
            forgotPasswordButton.topAnchor.constraint(
                equalTo: passwordStackView.bottomAnchor,
                constant: Metrics.margin
            ),
            forgotPasswordButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.margin
            ),
            forgotPasswordButton.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Metrics.ForgotPassword.widthMultiplier
            ),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: Metrics.ForgotPassword.height)
        )
    }
    
    private func constrainNextButton() {
        NSLayoutConstraint.activate(
            nextButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.margin
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.margin
            ),
            nextButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -Metrics.margin
            ),
            nextButton.heightAnchor.constraint(equalToConstant: Metrics.NextButton.height)
        )
    }
    
}
