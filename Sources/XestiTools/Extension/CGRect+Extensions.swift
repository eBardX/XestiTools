// © 2023 J. G. Pusey (see LICENSE.md)

import CoreGraphics

extension CGRect {
    
    // MARK: Public Instance Properties
    
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    public var integerRounded: CGRect {
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
    
    if result == -0 {
        return 0
    }
    
    return result
}
