// © 2024–2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension UUID {

    // MARK: Public Instance Properties

    public var base62String: String {
        Octaword(uuid: self).base62String()
    }

    public var hexString: String {
        uuidString
            .replacingOccurrences(of: "-",
                                  with: "")
            .lowercased()
    }
}

// MARK: -

private struct Octaword {

    // MARK: Fileprivate Initializers

    fileprivate init(uuid: UUID) {
        let uval = uuid.uuid

        //
        // According to RFC 9562, a UUID is stored in big-endian format;
        // therefore, care must be taken when converting it to a 128-bit
        // unsigned integer (Octaword):
        //
        let hiBits = (UInt64(uval.0) << (7 * 8) |
                      UInt64(uval.1) << (6 * 8) |
                      UInt64(uval.2) << (5 * 8) |
                      UInt64(uval.3) << (4 * 8) |
                      UInt64(uval.4) << (3 * 8) |
                      UInt64(uval.5) << (2 * 8) |
                      UInt64(uval.6) << (1 * 8) |
                      UInt64(uval.7) << (0 * 8))
        let loBits = (UInt64(uval.8) << (7 * 8) |
                      UInt64(uval.9) << (6 * 8) |
                      UInt64(uval.10) << (5 * 8) |
                      UInt64(uval.11) << (4 * 8) |
                      UInt64(uval.12) << (3 * 8) |
                      UInt64(uval.13) << (2 * 8) |
                      UInt64(uval.14) << (1 * 8) |
                      UInt64(uval.15) << (0 * 8))

        self.init(hiBits: hiBits,
                  loBits: loBits)
    }

    // MARK: Fileprivate Instance Methods

    fileprivate func base62String() -> String {
        var result = ""

        result.reserveCapacity(22)

        var value = self
        var digit = 0

        for _ in 1...22 {
            (value, digit) = Self._computeBase62Digit(value)

            result.append(Self.base62Digits[digit])
        }

        return String(result.reversed())
    }

    // MARK: Private Type Properties

    private static let base62Digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                                                    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                                                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
                                                    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                                                    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    private static let bitWidth = 128
    private static let radix = 62
    private static let zeroOctaword = Self(value: 0)

    // MARK: Private Type Methods

    private static func _add(_ lhs: Self,
                             _ rhs: Self) -> Self {
        let (newLoBits, carry) = lhs.loBits.addingReportingOverflow(rhs.loBits)

        var (newHiBits, overflow) = lhs.hiBits.addingReportingOverflow(rhs.hiBits)

        guard !overflow
        else { fatalError("overflow") }

        if carry {
            (newHiBits, overflow) = newHiBits.addingReportingOverflow(1)

            guard !overflow
            else { fatalError("overflow") }
        }

        return Self(hiBits: newHiBits,
                    loBits: newLoBits)
    }

    private static func _computeBase62Digit(_ value: Self) -> (Self, Int) {
        guard value.hiBits != 0 || value.loBits != 0
        else { return (zeroOctaword, 0) }

        guard !_lessThan(value, radix)
        else { return (zeroOctaword, Int(value.loBits)) }

        let radixOctaword = Self(value: radix)
        let dlz = radixOctaword.leadingZeroBitCount

        var quotient = zeroOctaword
        var remainder = value

        while !_lessThan(remainder, radix) {
            let rlz = remainder.leadingZeroBitCount
            let shift: Int

            var divisor = radixOctaword

            if rlz < dlz {
                shift = dlz - rlz - 1
                divisor = _leftShift(divisor, shift)
            } else {
                shift = 0
            }

            let multiple = Self(bit: shift)

            while !_lessThan(remainder, divisor) {
                remainder = _subtract(remainder, divisor)
                quotient = _add(quotient, multiple)
            }
        }

        return (quotient, Int(remainder.loBits))
    }

    private static func _leftShift(_ lhs: Self,
                                   _ shift: Int) -> Self {
        precondition(shift >= 0 && shift < bitWidth)

        guard shift > 0
        else { return lhs }

        if shift > UInt64.bitWidth {
            return Self(hiBits: lhs.loBits << (shift - UInt64.bitWidth),
                        loBits: 0)
        }

        var hiBits = lhs.hiBits << shift

        hiBits |= lhs.loBits >> (UInt64.bitWidth - shift)

        let loBits = lhs.loBits << shift

        return Self(hiBits: hiBits,
                    loBits: loBits)
    }

    private static func _lessThan(_ lhs: Self,
                                  _ rhs: Int) -> Bool {
        precondition(rhs >= 0)

        return lhs.hiBits == 0 && lhs.loBits < UInt64(rhs)
    }

    private static func _lessThan(_ lhs: Self,
                                  _ rhs: Self) -> Bool {
        lhs.hiBits < rhs.hiBits || (lhs.hiBits == rhs.hiBits && lhs.loBits < rhs.loBits)
    }

    private static func _subtract(_ lhs: Self,
                                  _ rhs: Self) -> Self {
        let (newLoBits, borrow) = lhs.loBits.subtractingReportingOverflow(rhs.loBits)

        var (newHiBits, overflow) = lhs.hiBits.subtractingReportingOverflow(rhs.hiBits)

        guard !overflow
        else { fatalError("overflow") }

        if borrow {
            (newHiBits, overflow) = newHiBits.subtractingReportingOverflow(1)

            guard !overflow
            else { fatalError("overflow") }
        }

        return Self(hiBits: newHiBits,
                    loBits: newLoBits)
    }

    // MARK: Private Initializers

    private init(bit: Int) {
        precondition(bit >= 0 && bit < Self.bitWidth)

        if bit < UInt64.bitWidth {
            self.hiBits = 0
            self.loBits = UInt64(1) << bit
        } else {
            self.hiBits = UInt64(1) << (bit - UInt64.bitWidth)
            self.loBits = 0
        }
    }

    private init(hiBits: UInt64,
                 loBits: UInt64) {
        self.hiBits = hiBits
        self.loBits = loBits
    }

    private init(value: Int) {
        precondition(value >= 0)

        self.hiBits = 0
        self.loBits = UInt64(value)
    }

    // MARK: Private Instance Properties

    private let hiBits: UInt64
    private let loBits: UInt64

    private var leadingZeroBitCount: Int {
        if hiBits == 0 {
            hiBits.bitWidth + loBits.leadingZeroBitCount
        } else {
            hiBits.leadingZeroBitCount
        }
    }
}
