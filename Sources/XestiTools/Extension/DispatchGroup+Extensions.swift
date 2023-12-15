// © 2023 J. G. Pusey (see LICENSE.md)

import Dispatch

extension DispatchGroup {
    
    // MARK: Public Instance Methods
    
    public func sync<T>(_ work: (@escaping (T) -> Void) -> Void) -> T {
        var result: T?
        
        enter()
        
        work {
            result = $0
            
            self.leave()
        }
        
        wait()
        
        guard let unwrappedResult = result
        else { fatalError("Hell has frozen over!") }
        
        return unwrappedResult
    }
}
