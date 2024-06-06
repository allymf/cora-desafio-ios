import Foundation

public protocol Decoding {
    func decode<T>(
        _ type: T.Type,
        from data: Data
    ) throws -> T where T : Decodable
}

extension JSONDecoder: Decoding {}
