// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiTools

struct ResultExtensionsTests {
}

// MARK: -

extension ResultExtensionsTests {
    @Test
    func test_failure() {
        let result: Result<String, TestError> = .failure(.someError)

        #expect(result.success == nil)
        #expect(result.failure == .someError)
    }

    @Test
    func test_init_bothSuccessAndFailure() {
        let result = Result<Int, TestError>(success: 42,
                                            failure: .someError,
                                            noResult: .noResult)

        #expect(result.success == nil)
        #expect(result.failure == .someError)
    }

    @Test
    func test_init_failure() {
        let result = Result<Int, TestError>(success: nil,
                                            failure: .someError,
                                            noResult: .noResult)

        #expect(result.success == nil)
        #expect(result.failure == .someError)
    }

    @Test
    func test_init_neitherSuccessNorFailure() {
        let result = Result<Int, TestError>(success: nil,
                                            failure: nil,
                                            noResult: .noResult)

        #expect(result.success == nil)
        #expect(result.failure == .noResult)
    }

    @Test
    func test_init_success() {
        let result = Result<Int, TestError>(success: 42,
                                            failure: nil,
                                            noResult: .noResult)

        #expect(result.success == 42)
        #expect(result.failure == nil)
    }

    @Test
    func test_onFailure_calledForFailure() {
        let result: Result<Int, TestError> = .failure(.someError)

        var called = false

        result.onFailure { error in
            #expect(error == .someError)

            called = true
        }

        #expect(called)
    }

    @Test
    func test_onFailure_notCalledForSuccess() {
        let result: Result<Int, TestError> = .success(42)

        var called = false

        result.onFailure { _ in
            called = true
        }

        #expect(!called)
    }

    @Test
    func test_onFailure_returnsOriginalResult() {
        let result: Result<Int, TestError> = .failure(.someError)
        let returned = result.onFailure { _ in }

        #expect(returned.failure == .someError)
    }

    @Test
    func test_onSuccess_calledForSuccess() {
        let result: Result<Int, TestError> = .success(42)

        var called = false

        result.onSuccess { value in
            #expect(value == 42)

            called = true
        }

        #expect(called)
    }

    @Test
    func test_onSuccess_notCalledForFailure() {
        let result: Result<Int, TestError> = .failure(.someError)

        var called = false

        result.onSuccess { _ in
            called = true
        }

        #expect(!called)
    }

    @Test
    func test_onSuccess_returnsOriginalResult() {
        let result: Result<Int, TestError> = .success(42)
        let returned = result.onSuccess { _ in }

        #expect(returned.success == 42)
    }

    @Test
    func test_success() {
        let result: Result<String, TestError> = .success("hello")

        #expect(result.success == "hello")
        #expect(result.failure == nil)
    }
}
