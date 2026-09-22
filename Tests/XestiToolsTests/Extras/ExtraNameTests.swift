// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
import XestiTools

struct ExtraNameTests {
}

// MARK: -

extension ExtraNameTests {
    @Test
    func init_emptyStringReturnsNil() {
        let name = Extra.Name(stringValue: "")

        #expect(name == nil)
    }

    @Test
    func init_validString() {
        let name = Extra.Name(stringValue: "comment")

        #expect(name?.stringValue == "comment")
    }

    @Test
    func isValid_digitFirstCharacterIsInvalid() {
        #expect(!Extra.Name.isValid("1comment"))
    }

    @Test
    func isValid_lettersAndDigitsIsValid() {
        #expect(Extra.Name.isValid("comment1"))
    }

    @Test
    func isValid_lettersOnlyIsValid() {
        #expect(Extra.Name.isValid("comment"))
    }

    @Test
    func isValid_nonASCIIFirstCharacterIsInvalid() {
        #expect(!Extra.Name.isValid("café"))
    }

    @Test
    func isValid_punctuationIsInvalid() {
        #expect(!Extra.Name.isValid("comment-1"))
    }

    @Test
    func isValid_singleLetterIsValid() {
        #expect(Extra.Name.isValid("c"))
    }

    @Test
    func isValid_whitespaceIsInvalid() {
        #expect(!Extra.Name.isValid("comment 1"))
    }
}
