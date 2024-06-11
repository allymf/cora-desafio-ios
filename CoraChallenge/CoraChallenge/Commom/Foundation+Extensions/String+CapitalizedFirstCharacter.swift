import Foundation

extension StringProtocol {
    var capitalizedFirstCharacter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
