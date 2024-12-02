import Foundation

public protocol Uniqueable: Codable, Hashable {
    associatedtype UniqueID: Codable, Hashable

    var uniqueID: UniqueID { get }
}

// MARK: - (defaults)

extension Uniqueable {

    // MARK: Public Type Methods

    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.uniqueID == rhs.uniqueID
    }

    // MARK: Public Instance Methods

    public func hash(into hasher: inout Hasher) {
        uniqueID.hash(into: &hasher)
    }
}
