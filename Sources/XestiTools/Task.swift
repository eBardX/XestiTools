// © 2020–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public protocol Task {
    typealias DataHandler = (Data) -> Void

    typealias Result = (status: Int, output: Data, error: Data)

    @discardableResult
    func run(outputDataHandler: DataHandler?,
             errorDataHandler: DataHandler?) throws -> Result
}
