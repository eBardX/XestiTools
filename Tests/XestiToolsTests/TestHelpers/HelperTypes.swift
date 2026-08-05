// © 2026 John Gary Pusey (see LICENSE.md)

import XestiTools

struct TestEnhancedError: EnhancedError {
    init(message: String,
         category: Category? = nil,
         cause: (any EnhancedError)? = nil) {
        self.category = category
        self.cause = cause
        self.message = message
    }

    let category: Category?
    let cause: (any EnhancedError)?
    let message: String
}

enum TestError: Error, Equatable {
    case noResult
    case someError
}

struct TestFloatType: FloatRepresentable {
    static func isValid(_ doubleValue: Double) -> Bool {
        doubleValue >= 0
    }

    init?(doubleValue: Double) {
        guard Self.isValid(doubleValue)
        else { return nil }

        self.doubleValue = doubleValue
    }

    let doubleValue: Double
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
