import UIKit

final class WelcomeView: UIView {
    
    // MARK: - Metrics
    enum Metrics {
        enum LogoImageView {
            static var margin: CGFloat = 16
            static var width: CGFloat = 90
            static var height: CGFloat = 24
        }
        
        enum PersonImageView {
            static var height: CGFloat = 340
        }
        
        enum LabelsStackView {
            static var margin: CGFloat = 16
            static var spacing: CGFloat = 16
        }
        
        enum TitleLabel {
            static var fontSize: CGFloat = 28
        }
        
        enum RationaleLabel {
            static var fontSize: CGFloat = 16
        }
        
        enum ButtonStackView {
            static var spacing: CGFloat = 16
            static var margin: CGFloat = 16
            static var bottomMargin: CGFloat = 8
            static var height: CGFloat = 128
        }
        
        enum SignUpButton {
            static var fontSize: CGFloat = 16
            static var height: CGFloat = 64
        }
        
        enum LoginButton {
            static var height: CGFloat = 48
        }
    }

    // MARK: - Subviews
    private let logoImageView = {
        let imageView = UIImageView(image: UIImage(named: "coraLogo"))
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let personImageView = {
        let imageView = UIImageView(image: UIImage(named: "welcomeBackground"))
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var labelsStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(rationaleLabel)
        
        stackView.axis = .vertical
        stackView.spacing = Metrics.LabelsStackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        
        label.text = String(localized: "WelcomeScene.Title")
        label.textAlignment = .left
        label.font = .avenir(size: Metrics.TitleLabel.fontSize)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var rationaleLabel = {
        let label = UILabel()
        
        label.text = String(localized: "WelcomeScene.Rationale")
        label.textAlignment = .left
        label.textColor = .white
        label.font = .avenir(size: Metrics.RationaleLabel.fontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var buttonStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(loginButton)
        
        stackView.axis = .vertical
        stackView.spacing = Metrics.ButtonStackView.spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var signUpButton = {
        let button = CoraButton()
        
        var configuration = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = .avenir(size: Metrics.SignUpButton.fontSize)
        
        let attributedTitle = AttributedString.init(
            String(localized: "WelcomeScene.SignUp.Title"),
            attributes: container
        )
        
        configuration.attributedTitle = attributedTitle
        configuration.image = UIImage(named: "arrowRight")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 150
        configuration.baseForegroundColor = .mainPink
        configuration.baseBackgroundColor = .white
        
        button.configuration = configuration
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var loginButton = {
        let button = CoraButton(style: .default)
        button.setTitle(
            String(localized: "WelcomeScene.Login.Title"),
            for: .normal
        )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .mainPink
        
        addSubViews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout
extension WelcomeView {
    
    func addSubViews() {
        addSubviews(
            personImageView,
            logoImageView,
            labelsStackView,
            buttonStackView
        )
    }
    
    func constrainSubviews() {
        constrainButtonStackView()
        constrainSignUpButton()
        constrainLoginButton()
        constrainLabelStackView()
        constrainLogoImageView()
        constrainPersonImageView()
    }
    
    private func constrainButtonStackView() {
        NSLayoutConstraint.activate(
            buttonStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.ButtonStackView.margin
            ),
            buttonStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.ButtonStackView.margin
            ),
            buttonStackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -Metrics.ButtonStackView.bottomMargin
            )
        )
    }
    
    private func constrainSignUpButton() {
        NSLayoutConstraint.activate(
                signUpButton.heightAnchor.constraint(equalToConstant: Metrics.SignUpButton.height)
        )
    }
    
    private func constrainLoginButton() {
        NSLayoutConstraint.activate(
                loginButton.heightAnchor.constraint(equalToConstant: Metrics.LoginButton.height)
        )
    }
    
    private func constrainLabelStackView() {
        NSLayoutConstraint.activate(
            labelsStackView.topAnchor.constraint(
                equalTo: personImageView.bottomAnchor,
                constant: Metrics.LabelsStackView.margin
            ),
            labelsStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.LabelsStackView.margin
            ),
            labelsStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.LabelsStackView.margin
            )
        )
    }
    
    private func constrainLogoImageView() {
        NSLayoutConstraint.activate(
            logoImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Metrics.LogoImageView.margin
            ),
            logoImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.LogoImageView.margin
            ),
            logoImageView.widthAnchor.constraint(equalToConstant: Metrics.LogoImageView.width),
            logoImageView.heightAnchor.constraint(equalToConstant: Metrics.LogoImageView.height)
        )
    }
    
    private func constrainPersonImageView() {
        NSLayoutConstraint.activate(
            personImageView.topAnchor.constraint(equalTo: topAnchor),
            personImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            personImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            personImageView.heightAnchor.constraint(equalToConstant: Metrics.PersonImageView.height)
        )
    }
    
}
