import UIKit

public extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
    
}
