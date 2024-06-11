import UIKit

open class KeyboardAdjustableViewController: CoraViewController {
    
    private let notificationCenter: NotificationCenter
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required public init?(coder: NSCoder) {
        fatalError("View Controller not intended for Interface Builder")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        super.viewWillDisappear(animated)
    }
    
    @objc
    private func keyboardWillChange(_ notification: Notification) {
        let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        guard isKeyBoardShowing else {
            return keyboardIsHiding()
        }
        
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        
        keyboardIsShowing(keyboardHeight: keyboardHeight)
    }
    
    open func keyboardIsShowing(keyboardHeight: CGFloat) {}
    
    open func keyboardIsHiding() {}
    
}
