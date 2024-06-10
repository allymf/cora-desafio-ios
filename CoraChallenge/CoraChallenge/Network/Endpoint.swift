import Foundation

public protocol Endpoint {
    var path: String { get }
    var urlParameters: [String: String]? { get }
    var bodyParameters: [String: String]? { get }
    var headerParameters: [String: String]? { get }
    var method: HTTPMethod { get }
}
