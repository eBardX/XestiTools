import Foundation
import Testing
@testable import XestiTools

@Suite
struct ExtraAssociatedValueTests {
}

// MARK: -

extension ExtraAssociatedValueTests {

    @Test
    func codable_bool() throws {
        let original = Extra.AssociatedValue.bool(true)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.AssociatedValue.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_double() throws {
        let original = Extra.AssociatedValue.double(1.5)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.AssociatedValue.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_int() throws {
        let original = Extra.AssociatedValue.int(42)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.AssociatedValue.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_string() throws {
        let original = Extra.AssociatedValue.string("hello")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.AssociatedValue.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func encode_bool() throws {
        let data = try JSONEncoder().encode(Extra.AssociatedValue.bool(false))
        let json = try #require(String(data: data, encoding: .utf8))

        #expect(json == "false")
    }

    @Test
    func encode_int() throws {
        let data = try JSONEncoder().encode(Extra.AssociatedValue.int(42))
        let json = try #require(String(data: data, encoding: .utf8))

        #expect(json == "42")
    }

    @Test
    func encode_string() throws {
        let data = try JSONEncoder().encode(Extra.AssociatedValue.string("hello"))
        let json = try #require(String(data: data, encoding: .utf8))

        #expect(json == #""hello""#)
    }

    @Test
    func equality() {
        let trueVal = Extra.AssociatedValue.bool(true)

        #expect(trueVal == Extra.AssociatedValue.bool(true))
        #expect(Extra.AssociatedValue.bool(true) != Extra.AssociatedValue.bool(false))
        #expect(Extra.AssociatedValue.int(1) != Extra.AssociatedValue.bool(true))
        #expect(Extra.AssociatedValue.string("a") != Extra.AssociatedValue.int(1))
    }
}
