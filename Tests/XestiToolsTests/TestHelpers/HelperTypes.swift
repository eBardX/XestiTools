// © 2026 John Gary Pusey (see LICENSE.md)

import XestiTools

enum TestError: Error, Equatable {
    case someError
    case noResult
}

struct TestIntType: IntRepresentable {
    static func isValid(_ intValue: Int) -> Bool {
        intValue >= 0
    }

    init?(intValue: Int) {
        guard Self.isValid(intValue)
        else { return nil }

        self.intValue = intValue
    }

    let intValue: Int
}

typealias TestStringType = XestiTools.Category

struct TestUIntType: UIntRepresentable {
    static func isValid(_ uintValue: UInt) -> Bool {
        uintValue > 0
    }

    init?(uintValue: UInt) {
        guard Self.isValid(uintValue)
        else { return nil }

        self.uintValue = uintValue
    }

    let uintValue: UInt
}
