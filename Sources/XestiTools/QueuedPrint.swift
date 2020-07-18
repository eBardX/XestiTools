// © 2018–2020 J. G. Pusey (see LICENSE.md)

import Dispatch
import Foundation

public func qfatalError(_ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) -> Never {
    outputQueue.sync {
        fflush(stdout)

        let file = ("\(file)" as NSString).lastPathComponent

        fputs("\(message()): file \(file), line \(line)\n", stderr)
    }

    abort()
}

public func qprint(_ item: Any,
                   terminator: String = "\n") {
    outputQueue.async {
        print(item,
              terminator: terminator)
    }
}

public func qprintError(_ item: Any,
                        terminator: String = "\n") {
    outputQueue.async {
        fflush(stdout)
        fputs(String(describing: item) + terminator, stderr)
    }
}

private let outputQueue: DispatchQueue = {
    let queue = DispatchQueue(label: "com.xesticode.QueuedPrint.outputQueue",
                              qos: .userInteractive,
                              target: .global(qos: .userInteractive))

    atexit_b {
        queue.sync(flags: .barrier) {}
    }

    return queue
}()
