import UIKit

public protocol KeyboardAdjustableViewProtocol {
    func updateNextButtonBottomConstraint(keyboardHeight: CGFloat)
    func resetNextButtonBottomConstraint()
}
