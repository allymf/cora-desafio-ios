import UIKit

protocol LoginPasswordActions {
    var didTapNextButton: (String?) -> Void { get }
}

protocol LoginPasswordViewProtocol: ViewInitializer, KeyboardAdjustableViewProtocol {
    var actions: LoginPasswordActions? { get set }
    
    func stopLoading()
}

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
        
        textField.becomeFirstResponder()
        textField.delegate = self
        
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
        button.isEnabled = false
        
        button.addTarget(
            self,
            action: #selector(didTapNextButton),
            for: .touchUpInside
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let loadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private var nextButtonBottomConstraint: NSLayoutConstraint?

    public override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.configuration?.imagePadding = nextButton.frame.width * Metrics.NextButton.imagePaddingMultiplier
    }
    
    // MARK: - Public API
    var actions: LoginPasswordActions?
    
    public func updateNextButtonBottomConstraint(keyboardHeight: CGFloat) {
        let newBottomConstant = (keyboardHeight - safeAreaInsets.bottom) + Metrics.margin
        updateNextButtonBottomConstraint(constant: newBottomConstant)
    }
    
    public func resetNextButtonBottomConstraint() {
        updateNextButtonBottomConstraint(constant: Metrics.margin)
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
    
    // MARK: - Public API
    func stopLoading() {
        loadingView.removeFromSuperview()
    }
    
    // MARK: - Button Tap Methods
    @objc
    private func didTapPasswordToggleButton() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func didTapNextButton() {
        addSubview(loadingView)
        constrainLoadingView()
        let passwordText = passwordTextField.text
        actions?.didTapNextButton(passwordText)
    }
    
}

// MARK: - Contraint Related Methods
private extension LoginPasswordView {
    func constrainInsertPasswordLabel() {
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
    
    func constrainPasswordStackView() {
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
    
    func constrainPasswordToggleButton() {
        NSLayoutConstraint.activate(
            passwordToggleButton.widthAnchor.constraint(equalToConstant: Metrics.PasswordToggleButton.width)
        )
    }
    
    func constrainForgotPasswordButton() {
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
    
    func constrainNextButton() {
        let nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor,
            constant: -Metrics.margin
        )
        self.nextButtonBottomConstraint = nextButtonBottomConstraint
        
        NSLayoutConstraint.activate(
            nextButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.margin
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.margin
            ),
            nextButtonBottomConstraint,
            nextButton.heightAnchor.constraint(equalToConstant: Metrics.NextButton.height)
        )
    }
    
    func constrainLoadingView() {
        NSLayoutConstraint.activate(
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        )
    }
    
    func updateNextButtonBottomConstraint(constant: CGFloat) {
        nextButtonBottomConstraint?.constant = -constant
        
        UIView.animate(
            withDuration: 0
        ) {
            self.layoutIfNeeded()
        }
    }
}

extension LoginPasswordView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let passwordLength = textField.text?.count else { return }
        let isPasswordLengthCorrect = passwordLength >= 6
        
        nextButton.isEnabled = isPasswordLengthCorrect
    }
}
