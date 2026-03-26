// © 2023–2026 John Gary Pusey (see LICENSE.md)

public import CoreGraphics

extension CGRect {

    // MARK: Public Instance Properties

    /// The center point of this rectangle.
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

    /// A rectangle with the `minX`, `minY`, `maxX`, and `maxY` values of this
    /// rectangle rounded to the nearest whole integers.
    public var integerRounded: Self {
        let rminX = _fround(minX)
        let rminY = _fround(minY)
        let rmaxX = _fround(maxX)
        let rmaxY = _fround(maxY)

        return CGRect(x: rminX,
                      y: rminY,
                      width: rmaxX - rminX,
                      height: rmaxY - rminY)
    }
}

// MARK: Private Functions

private func _fround(_ value: CGFloat) -> CGFloat {
    let result = round(value)

    if result.isZero && result.sign == .minus {
        return 0
    }

    return result
}
