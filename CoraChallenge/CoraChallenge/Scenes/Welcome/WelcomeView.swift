import UIKit

final class WelcomeView: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
