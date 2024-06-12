import Foundation

extension String {
    var capitalizedFirstCharacter: String {
        guard count >= 1 else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
}
