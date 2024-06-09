import UIKit

final class CoraButton: UIButton {
    
    struct Style {
        let font: UIFont?
        let backgroundColor: UIColor
        let tintColor: UIColor
        let disabledBackgroundColor: UIColor = .disabledButtonGray
    }
    
    enum Metrics {
        static var cornerRadius: CGFloat = 16
        static var defaultFontSize: CGFloat = 14
        static var largeFontSize: CGFloat = 16
    }
    
    private let style: Style

    init(frame: CGRect = .zero, style: Style = .defaultPink) {
        self.style = style
        super.init(frame: frame)
        setupStyle()
        additionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is not intended for Interface Builder.")
    }
    
    override var isEnabled: Bool {
    
        didSet {
            guard isEnabled else {
                backgroundColor = style.disabledBackgroundColor
                return
            }
            
            backgroundColor = style.backgroundColor
        }
        
    }
    
    private func setupStyle() {
        titleLabel?.font = style.font
        setTitleColor(
            style.tintColor,
            for: .normal
        )
        imageView?.tintColor = style.tintColor
        backgroundColor = style.backgroundColor
    }
    
    private func additionalSettings() {
        clipsToBounds = true
        layer.cornerRadius = Metrics.cornerRadius
    }
    
}
