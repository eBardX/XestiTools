// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct ExtrasFormatStyleTests {
}

// MARK: -

extension ExtrasFormatStyleTests {
    @Test
    func format_empty() {
        let style = Extras.FormatStyle()

        #expect(style.format(Extras()) == AttributedString())
    }

    @Test
    func format_multipleElements() {
        let style = Extras.FormatStyle()
        let extras = Extras(elements: [.marker, .comment("hi")])

        #expect(style.format(extras) == AttributedString("comment(hi), marker"))
    }

    @Test
    func formatted_usesDefaultStyle() {
        let extras = Extras(elements: [.marker])

        #expect(extras.formatted() == AttributedString("marker"))
    }

    @Test
    func init_customLocale() {
        let locale = Locale(identifier: "fr_FR")
        let style = Extras.FormatStyle(locale: locale)

        #expect(style.locale == locale)
    }

    @Test
    func init_defaultLocale() {
        let style = Extras.FormatStyle()

        #expect(style.locale == Locale.autoupdatingCurrent)
    }

    @Test
    func locale_returnsModifiedCopy() {
        let original = Extras.FormatStyle()
        let locale = Locale(identifier: "de_DE")
        let modified = original.locale(locale)

        #expect(original.locale == Locale.autoupdatingCurrent)
        #expect(modified.locale == locale)
    }
}
