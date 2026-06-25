# XestiTools

Tools to ease writing Swift code.

## <a name="overview">Overview</a>

The XestiTools package provides a collection of tools to facilitate writing
Swift programs. It is organized into three frameworks:

- **XestiTools** — the core framework, with extensions to standard types, file
  path utilities, string interpolation, subprocess support, and more.
- **XestiToolsCLI** — CLI-oriented additions built on top of
  [swift-argument-parser][sap], including command runners and helpers for
  building command-line tools.
- **XestiToolsZIP** — ZIP archive support built on top of [ZIPFoundation][zipf],
  with extensions for `Data`, `FileWrapper`, and file paths.

## <a name="reference_documentation">Reference Documentation</a>

Full [reference documentation][refdoc] is available courtesy of [DocC][docc].

## <a name="credits">Credits</a>

John Gary Pusey (ebardx@gmail.com)

## <a name="license">License</a>

XestiTools is available under [the MIT license][license].

[docc]:     https://www.swift.org/documentation/docc/
[license]:  https://github.com/eBardX/XestiTools/blob/main/LICENSE.md
[refdoc]:   https://eBardX.github.io/xesti-packages-docs/documentation/xestitools
[sap]:      https://github.com/apple/swift-argument-parser
[zipf]:     https://github.com/weichsel/ZIPFoundation
