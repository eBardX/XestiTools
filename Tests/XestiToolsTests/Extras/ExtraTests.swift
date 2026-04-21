import Foundation
import Testing
@testable import XestiTools

@Suite
struct ExtraTests {
}

// MARK: -

extension ExtraTests {

    @Test
    func codable_comment() throws {
        let original = Extra.comment("hi")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_custom() throws {
        let original = Extra.fubar(42, "world")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_marker() throws {
        let original = Extra.marker
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func codable_special() throws {
        let original = Extra.special
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extra.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func description_noValues() {
        #expect(Extra.marker.description == "marker")
        #expect(Extra.special.description == "special")
    }

    @Test
    func description_withValues() {
        #expect(Extra.comment("hello").description == "comment(hello)")
        #expect(Extra.fubar(42, "world").description == "fubar(42, world)")
    }

    @Test
    func encode_comment() throws {
        let data = try JSONEncoder().encode(Extra.comment("hi"))
        let json = try #require(String(data: data, encoding: .utf8))

        #expect(json == #"["comment","hi"]"#)
    }

    @Test
    func encode_marker() throws {
        let data = try JSONEncoder().encode(Extra.marker)
        let json = try #require(String(data: data, encoding: .utf8))

        #expect(json == #""marker""#)
    }

    @Test
    func equality() {
        let marker = Extra.marker
        #expect(marker == Extra.marker)
        #expect(Extra.marker != Extra.special)
        let comment = Extra.comment("hi")
        #expect(comment == Extra.comment("hi"))
        #expect(Extra.comment("hi") != Extra.comment("bye"))
    }

    @Test
    func init_noValues() {
        let extra = Extra(name: "test")

        #expect(extra.name == "test")
        #expect(extra.values.isEmpty)
    }

    @Test
    func init_withValues() {
        let extra = Extra(name: "test", values: [.int(1), .string("x")])

        #expect(extra.name == "test")
        #expect(extra.values == [.int(1), .string("x")])
    }
}
