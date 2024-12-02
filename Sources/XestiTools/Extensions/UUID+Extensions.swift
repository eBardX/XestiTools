import Foundation

extension UUID {

    // MARK: Public Instance Properties

    public var hexString: String {
        uuidString.replacingOccurrences(of: "-",
                                        with: "").lowercased()
    }
}
