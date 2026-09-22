// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
import XestiTools

struct ExtraFormatStyleTests {
}

// MARK: -

extension ExtraFormatStyleTests {
    @Test
    func format_boolValue() {
        let style = Extra.FormatStyle()
        let extra = Extra(name: "flag",
                          values: [.bool(true)])

        #expect(style.format(extra) == AttributedString("flag(true)"))
    }

    @Test
    func format_intValueUsesLocaleGroupSeparator_deDE() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "de_DE"))
        let extra = Extra(name: "count",
                          values: [.int(1_234_567)])

        #expect(style.format(extra) == AttributedString("count(1.234.567)"))
    }

    @Test
    func format_intValueUsesLocaleGroupSeparator_enUS() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "en_US"))
        let extra = Extra(name: "count",
                          values: [.int(1_234_567)])

        #expect(style.format(extra) == AttributedString("count(1,234,567)"))
    }

    @Test
    func format_intValueUsesLocaleGroupSeparator_frFR() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "fr_FR"))
        let extra = Extra(name: "count",
                          values: [.int(1_234_567)])

        #expect(style.format(extra) == AttributedString("count(1\u{202f}234\u{202f}567)"))
    }

    @Test
    func format_doubleValueUsesLocaleDecimalSeparator_deDE() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "de_DE"))
        let extra = Extra(name: "average",
                          values: [.double(1_234.5)])

        #expect(style.format(extra) == AttributedString("average(1.234,5)"))
    }

    @Test
    func format_doubleValueUsesLocaleDecimalSeparator_enUS() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "en_US"))
        let extra = Extra(name: "average",
                          values: [.double(1_234.5)])

        #expect(style.format(extra) == AttributedString("average(1,234.5)"))
    }

    @Test
    func format_doubleValueUsesLocaleDecimalSeparator_frFR() {
        let style = Extra.FormatStyle(locale: Locale(identifier: "fr_FR"))
        let extra = Extra(name: "average",
                          values: [.double(1_234.5)])

        #expect(style.format(extra) == AttributedString("average(1\u{202f}234,5)"))
    }

    @Test
    func format_multipleValues() {
        let style = Extra.FormatStyle()

        #expect(style.format(.fubar(1, "hi")) == AttributedString("fubar(1, hi)"))
    }

    @Test
    func format_noValues() {
        let style = Extra.FormatStyle()

        #expect(style.format(.marker) == AttributedString("marker"))
    }

    @Test
    func formatted_usesDefaultStyle() {
        #expect(Extra.marker.formatted() == AttributedString("marker"))
    }

    @Test
    func init_customLocale() {
        let locale = Locale(identifier: "fr_FR")
        let style = Extra.FormatStyle(locale: locale)

        #expect(style.locale == locale)
    }

    @Test
    func init_defaultLocale() {
        let style = Extra.FormatStyle()

        #expect(style.locale == Locale.autoupdatingCurrent)
    }

    @Test
    func locale_returnsModifiedCopy() {
        let original = Extra.FormatStyle()
        let locale = Locale(identifier: "de_DE")
        let modified = original.locale(locale)

        #expect(original.locale == Locale.autoupdatingCurrent)
        #expect(modified.locale == locale)
    }
}
