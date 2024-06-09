import UIKit

final class CPFTextField: UITextField {

    override func canPerformAction(
        _ action: Selector,
        withSender sender: Any?
    ) -> Bool {
        return false
    }

    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let textLength = self.text?.count ?? 0
        let end = self.position(from: beginning, offset: textLength)
        return end
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isFirstResponder
    }
    
}
