// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct RunLoopExtensionsTests {
}

// MARK: -

extension RunLoopExtensionsTests {
    @Test
    func defaultWaitInterval() {
        #expect(RunLoop.defaultWaitInterval == 0.1)
    }

    @Test
    func defaultWaitMessage() {
        #expect(RunLoop.defaultWaitMessage == "Timed out waiting")
    }

    @Test
    func defaultWaitTimeout() {
        #expect(RunLoop.defaultWaitTimeout == 60)
    }

    @Test
    func error_message() {
        let error = RunLoop.Error.timedOut("custom reason")

        #expect(error.message == "custom reason")
    }

    @Test
    func waitForValue_returnsImmediatelyAvailableValue() throws {
        let result = try RunLoop.waitForValue(timeout: 0.2) {
            42
        }

        #expect(result == 42)
    }

    @Test
    func waitForValue_returnsValueAfterRetries() throws {
        var attempts = 0

        let result = try RunLoop.waitForValue(timeout: 0.5,
                                              interval: 0.02) {
            attempts += 1

            return attempts >= 3 ? attempts : nil
        }

        #expect(result == 3)
    }

    @Test
    func waitForValue_throwsCustomMessageOnTimeout() {
        do {
            _ = try RunLoop.waitForValue(timeout: 0.1,
                                         message: "nope",
                                         interval: 0.02) {
                nil as Int?
            }

            Issue.record("Expected RunLoop.Error.timedOut to be thrown")
        } catch let RunLoop.Error.timedOut(message) {
            #expect(message == "nope")
        } catch {
            Issue.record("Unexpected error thrown: \(error)")
        }
    }

    @Test
    func wait_untilAction_succeedsImmediately() throws {
        try RunLoop.wait(until: true,
                         timeout: 0.2)
    }

    @Test
    func wait_untilAction_throwsOnTimeout() {
        #expect(throws: RunLoop.Error.self) {
            try RunLoop.wait(until: false,
                             timeout: 0.1,
                             interval: 0.02)
        }
    }
}
