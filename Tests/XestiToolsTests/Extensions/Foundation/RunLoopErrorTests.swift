// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct RunLoopErrorTests {
}

// MARK: -

extension RunLoopErrorTests {
    @Test
    func category_isNil() {
        let error = RunLoop.Error.timedOut("custom reason")

        #expect(error.category == nil)
    }

    @Test
    func cause_isNil() {
        let error = RunLoop.Error.timedOut("custom reason")

        #expect(error.cause == nil)
    }

    @Test
    func message() {
        let error = RunLoop.Error.timedOut("custom reason")

        #expect(error.message == "custom reason")
    }
}
