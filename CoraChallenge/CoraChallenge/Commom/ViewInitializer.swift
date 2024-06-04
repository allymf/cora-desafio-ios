import UIKit

public protocol ViewInitializer: AnyObject {
    var concreteView: UIView { get }
}

public extension ViewInitializer where Self: UIView {
    var concreteView: UIView { self }
}
