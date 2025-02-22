import Foundation

public enum HTTPMethod: String {
    case get,
        post
    
    var value: String { rawValue.uppercased() }
}
