import UIKit

extension UIColor {
    convenience public init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {
    static var mainPink = UIColor(rgb: 0xFE3E6D)
    static var primaryGray = UIColor(rgb: 0x3B3B3B)
    static var secondaryGray = UIColor(rgb: 0x6B7076)
    static var incomeBlue = UIColor(rgb: 0x1A93DA)
}

