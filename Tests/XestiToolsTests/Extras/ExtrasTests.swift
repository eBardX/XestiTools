import Foundation
import Testing
@testable import XestiTools

@Suite
struct ExtrasTests {
}

// MARK: -

extension ExtrasTests {

    @Test
    func codable() throws {
        let original = Extras(elements: [.marker, .special, .comment("hi")])
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Extras.self, from: data)

        #expect(decoded == original)
    }

    @Test
    func contains() {
        let extras = Extras(elements: [.marker])

        #expect(extras.contains(.marker))
        #expect(!extras.contains(.special))
    }

    @Test
    func elements_sorted() {
        let extras = Extras(elements: [.special, .marker, .comment("hi")])

        #expect(extras.elements.map { $0.name } == ["comment", "marker", "special"])
    }

    @Test
    func init_empty() {
        let extras = Extras()

        #expect(extras.isEmpty)
        #expect(extras.elements.isEmpty)
    }

    @Test
    func init_elements() {
        let extras = Extras(elements: [.marker, .special])

        #expect(!extras.isEmpty)
        #expect(extras.elements.count == 2)
    }

    @Test
    func insert() {
        var extras = Extras()

        extras.insert(.marker)

        #expect(extras.contains(.marker))
    }

    @Test
    func inserting() {
        let base = Extras()
        let result = base.inserting(.marker)

        #expect(!base.contains(.marker))
        #expect(result.contains(.marker))
    }

    @Test
    func remove() {
        var extras = Extras(elements: [.marker, .special])

        extras.remove(.marker)

        #expect(!extras.contains(.marker))
        #expect(extras.contains(.special))
    }

    @Test
    func remove_notPresent() {
        var extras = Extras(elements: [.marker])

        extras.remove(.special)

        #expect(extras.contains(.marker))
    }

    @Test
    func removing() {
        let base = Extras(elements: [.marker, .special])
        let result = base.removing(.marker)

        #expect(base.contains(.marker))
        #expect(!result.contains(.marker))
        #expect(result.contains(.special))
    }
}
