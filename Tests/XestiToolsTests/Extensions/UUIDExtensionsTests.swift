import XCTest
@testable import XestiTools

internal class UUIDExtensionsTests: XCTestCase {
}

// MARK: -

extension UUIDExtensionsTests {
    func test_matches() {
        XCTAssertEqual(UUID(uuidString: "00000000-0000-0000-0000-000000000000")?.base62String, "0000000000000000000000")
        XCTAssertEqual(UUID(uuidString: "00000000-0000-0000-0000-000000000001")?.base62String, "0000000000000000000001")
        XCTAssertEqual(UUID(uuidString: "00000000-0000-0000-0000-0000000000FF")?.base62String, "0000000000000000000047")
        XCTAssertEqual(UUID(uuidString: "00000000-0000-0000-FFFF-FFFFFFFFFFFF")?.base62String, "00000000000LygHa16AHYF")
        XCTAssertEqual(UUID(uuidString: "020F8F4D-6437-402A-96A3-262270D2780C")?.base62String, "03t5v494ZCVAgqx8QckT1g")
        XCTAssertEqual(UUID(uuidString: "1F9C5FC5-9EE7-424D-A357-E680EE9AED8D")?.base62String, "0xeDy4IyI84DXF6vxhK1VN")
        XCTAssertEqual(UUID(uuidString: "2462889B-1C7E-4D6A-B071-B542150A7A8F")?.base62String, "16ekjSAqVZgOurm6hI9pmh")
        XCTAssertEqual(UUID(uuidString: "4B4BC76E-7E4D-42A9-AA40-9A0DF4BAF293")?.base62String, "2I53Rrwhg30oq6VJEKziOx")
        XCTAssertEqual(UUID(uuidString: "7C240267-88CC-490A-B5BE-5234CB1C2C0A")?.base62String, "3mFVIm8t2EVPACa9YAnNZS")
        XCTAssertEqual(UUID(uuidString: "8D4AE5C1-65F9-4022-B735-C114C833ED95")?.base62String, "4Ic94ZLWDNHSkkGe85GTUD")
        XCTAssertEqual(UUID(uuidString: "996AF2E0-C241-4DA8-AFFA-2D6276AEE1CE")?.base62String, "4fUhVUS5JKAOyd9eXKT2XG")
        XCTAssertEqual(UUID(uuidString: "E3194386-38E9-4777-AC28-3B41A058792E")?.base62String, "6uWnpny9FKhKMlxDwmlrt0")
        XCTAssertEqual(UUID(uuidString: "E6EC87FC-5A7C-409C-BA2A-92D8105E948D")?.base62String, "71kKTXMlPhIjqauwutjHa9")
        XCTAssertEqual(UUID(uuidString: "E75AA1A6-C7C0-4816-9CE7-8F9A01A90336")?.base62String, "72Ye44zrSxErxUJYZNAgBa")
        XCTAssertEqual(UUID(uuidString: "FFFFFFFF-FFFF-FFFF-0000-000000000000")?.base62String, "7n42DGM5TflOB6rCs15Q3s")
        XCTAssertEqual(UUID(uuidString: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")?.base62String, "7n42DGM5Tflk9n8mt7Fhc7")
    }
}
