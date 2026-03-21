# XestiTools — Issues Report

Comprehensive code analysis of the XestiTools repository. Issues are grouped
by severity and organized by file.

---

## Critical Issues

### 1. Shell injection vulnerability in `BashScriptSubprocess._quote(_:)`

**File:** `Sources/XestiTools/Subprocess/BashScriptSubprocess.swift`

`_quote(_:)` wraps values in double quotes without escaping shell-special
characters (`$`, `` ` ``, `"`, `\`, `!`). A path or argument containing any of
these characters can cause arbitrary command execution. Should use single quotes
with interior `'` escaped, or proper shell escaping.

### 2. `_makeCocoaError` ignores its `code` parameter (bug — two files)

**Files:**
- `Sources/XestiTools/Extensions/Foundation/FileWrapper+Extensions.swift`
- `Sources/XestiTools/Extensions/Foundation/Data+Extensions.swift`

The function accepts a `CocoaError.Code` parameter but hard-codes
`.fileReadNoSuchFile`. Every call site passing `.fileReadUnknown`,
`.fileReadInvalidFileName`, etc. produces the wrong error code. The fix is to
use the `code` parameter instead of the hard-coded value.

### 3. Crash on decode in all three `Representable` protocols

**Files:**
- `Sources/XestiTools/Representable/StringRepresentable.swift`
- `Sources/XestiTools/Representable/IntRepresentable.swift`
- `Sources/XestiTools/Representable/UIntRepresentable.swift`

`init(from decoder:)` force-unwraps the result of the failable initializer
(e.g., `self.init(stringValue:)!`). If the decoded value is invalid per
`isValid(_:)`, this crashes at runtime instead of throwing a
`DecodingError.dataCorrupted`. The `init(stringLiteral:)` variants have the
same force-unwrap problem.

### 4. UTF-16 vs Character offset bug in `String.location(of:)`

**File:** `Sources/XestiTools/Extensions/Swift/String+Extensions.swift`

`distance(from: startIndex, to: position)` returns a count of `Character`
(grapheme clusters), but `NSRange(location:length:)` requires UTF-16 code-unit
offsets. For any string containing multi-code-unit characters (emoji, CJK,
combining marks), the resulting `NSRange` will be wrong, causing incorrect
line/column results or an out-of-bounds crash. Should use
`NSRange(position..<position, in: self)` or the UTF-16 view.

### 5. `AtomicFlag` is a struct — value semantics undermine atomicity

**File:** `Sources/XestiTools/Other/AtomicFlag.swift`

`AtomicFlag` is a `struct` wrapping `atomic_flag`. Because structs are value
types in Swift, every assignment, function parameter pass, or capture creates a
copy of the flag with independent state. This fundamentally breaks the purpose
of an atomic flag. Should be a `class`, or use `UnsafeMutablePointer` internally
to ensure identity semantics.

### 6. `totalSize()` can infinite-loop on symbolic link cycles

**File:** `Sources/XestiTools/FilePath/FilePath+Other.swift`

`totalSize()` recursively descends into directories, but `contentsOfDirectory()`
may return symbolic links pointing back up the tree. Since `kind()` on a symlink
resolves to the target's kind, a symlink pointing to a parent directory would
cause infinite recursion and a stack overflow crash.

---

## Major Issues

### 7. Race condition in `StandardIO.readInput(_:)`

**File:** `Sources/XestiTools/Other/StandardIO.swift`

The prompt is written asynchronously (`syncQueue.async`) but `readLine()` is
called synchronously immediately afterward. The prompt may not be flushed to
the terminal before input is expected.

### 8. Race between async error write and `Darwin.exit()`

**Files:**
- `Sources/XestiTools/CLI/AsyncCommandRunner.swift`
- `Sources/XestiTools/CLI/CommandRunner.swift`

`StandardIO().writeError(...)` dispatches the write asynchronously on a GCD
queue, then `Darwin.exit()` is called immediately after. The error message may
not be flushed before the process terminates.

### 9. All write methods silently swallow errors in `StandardIO`

**File:** `Sources/XestiTools/Other/StandardIO.swift`

Every write operation has empty `catch {}` blocks. If the output file handle
becomes invalid, is closed, or disk is full, writes silently fail with no way
for the caller to detect the failure.

### 10. `Sendable` conformance is unsound for `StandardIO`

**File:** `Sources/XestiTools/Other/StandardIO.swift`

`StandardIO` is declared `Sendable`, but it holds a `Formatter?`. `Formatter`
is a mutable reference type that is not inherently `Sendable`. If a mutable
`Formatter` subclass is passed in and modified from another thread, this
violates `Sendable` guarantees.

### 11. Deprecated `process.launch()` in `Subprocess`

**File:** `Sources/XestiTools/Subprocess/Subprocess.swift`

`process.launch()` is deprecated since macOS 10.13. Should use
`try process.run()` which throws a proper Swift error on failure instead of
raising an uncatchable Objective-C exception.

### 12. `Subprocess.run()` overrides constructor I/O

**File:** `Sources/XestiTools/Subprocess/Subprocess.swift`

`run()` replaces `standardError`, `standardInput`, and `standardOutput` with
its own pipes, silently discarding any custom `StandardIO` passed to the
initializer.

### 13. Potential data loss in `Subprocess.run()`

**File:** `Sources/XestiTools/Subprocess/Subprocess.swift`

After `waitUntilExit()`, the readability handler may have been invoked but not
yet dispatched to `dataQueue`. Setting the handler to `nil` immediately could
discard the final chunk of output.

### 14. Optional values stored as `Optional.none` in `[String: Any]` dictionary

**File:** `Sources/XestiTools/Other/EnhancedError.swift`

When properties like `error.helpAnchor` are `nil`, assigning them to a
`[String: Any]` dictionary stores `Optional<String>.none` as the `Any` value
rather than omitting the key. This is a well-known Swift gotcha and causes
issues with downstream JSON serialization.

### 15. `AsyncJSONValueSequence` does not handle CRLF line endings

**File:** `Sources/XestiTools/Other/AsyncJSONValueSequence.swift`

Only splits on `0x0A` (LF). If the input uses CRLF line endings (common in HTTP
responses), the trailing `\r` byte is included in the buffer and passed to
`JSONDecoder`, causing decode failures.

### 16. Deprecated `URL.path` usage

**Files:**
- `Sources/XestiTools/FilePath/FilePath+FileManager.swift` (3 occurrences)
- `Sources/XestiTools/Extensions/Foundation/Data+Extensions.swift`

`url.path` is deprecated on macOS 13+ / iOS 16+. The replacement is
`url.path(percentEncoded: false)`.

### 17. `currentDirectory` setter silently ignores failure

**File:** `Sources/XestiTools/FilePath/FilePath+FileManager.swift`

`FileManager.changeCurrentDirectoryPath` returns a `Bool` indicating success or
failure. The setter discards this return value, so
`FilePath.currentDirectory = somePath` can silently fail.

### 18. `posixPermissions` uses `Int16` instead of `UInt16`

**File:** `Sources/XestiTools/FilePath/FilePath.Attributes.swift`

POSIX permissions are stored as an unsigned short (`mode_t` / `UInt16`). Using
`Int16` is semantically wrong and can cause issues if the setuid/setgid/sticky
bits are set.

### 19. `NSNumber.isBoolean` uses pointer address comparison

**File:** `Sources/XestiTools/Extensions/Foundation/NSNumber+Extensions.swift`

`objCType == Self.booleanObjCType` compares `UnsafePointer<CChar>` addresses,
not the pointed-to string content. This works in practice because the ObjC
runtime interns type encoding strings, but this is an implementation detail, not
a documented guarantee.

### 20. Use of private KVC property `contentsURL` on `FileWrapper`

**File:** `Sources/XestiTools/Extensions/Foundation/FileWrapper+Extensions.swift`

`value(forKey: "contentsURL")` accesses an undocumented/private property via
KVC. This is fragile, could break silently on any OS update, and may cause App
Store rejection.

### 21. `Substring.location` force-unwrap crash risk

**File:** `Sources/XestiTools/Extensions/Swift/Substring+Extensions.swift`

The `location` property force-unwraps `base.location(of: startIndex)!`. Since
`String.location(of:)` can return `nil`, and the underlying method has a
Character-vs-UTF16 bug (see Critical issue #4), this is a potential crash site.

### 22. Uses private `_literalPattern` API on `Regex`

**File:** `Sources/XestiTools/Extensions/Swift/Regex+Extensions.swift`

`_literalPattern` is a private/underscored Apple API. This is fragile and can
break without notice across Swift or OS updates.

### 23. `AtomicFlag` `Sendable` conformance is misleading

**File:** `Sources/XestiTools/Other/AtomicFlag.swift`

Declaring a value type as `Sendable` means it can be sent across concurrency
domains — but each domain gets a copy, so the atomic flag serves no
synchronization purpose.

### 24. `StringRepresentable.init(stringLiteral:)` force-unwraps

**File:** `Sources/XestiTools/Representable/StringRepresentable.swift`

An invalid literal crashes at runtime. Same pattern exists in `IntRepresentable`
and `UIntRepresentable`.

---

## Minor Issues

### 25. `@_exported import ArgumentParser` leaks entire dependency

**File:** `Sources/XestiTools/CLI/CLI.swift`

`@_exported import` re-exports every public symbol from ArgumentParser to all
consumers of XestiTools. This is an underscored/unofficial attribute and can
cause name collisions downstream.

### 26. `URL(string:)` may reject valid file paths in `URL+CLI.swift`

**File:** `Sources/XestiTools/CLI/URL+CLI.swift`

`URL(string:)` does not handle file paths with spaces or special characters.
Consider falling back to `URL(fileURLWithPath:)` if `URL(string:)` returns
`nil`.

### 27. `match(pattern:)` uses Darwin-specific `glob`

**File:** `Sources/XestiTools/FilePath/FilePath+Other.swift`

The `glob()` function and `GLOB_BRACE`, `GLOB_TILDE` flags are Darwin-specific.
This code will not compile on Linux or Windows.

### 28. `JSONFormatter` imports `CoreGraphics` — Apple platforms only

**File:** `Sources/XestiTools/Other/JSONFormatter.swift`

The `CoreGraphics` import means this file cannot compile on Linux or Windows. CG-dependent methods should be conditionally compiled.

### 29. Silent NaN/Infinity replacement in `JSONFormatter`

**File:** `Sources/XestiTools/Other/JSONFormatter.swift`

NaN is silently replaced with `0`, and infinity with extreme finite values.
This behavior is undocumented and could surprise callers.

### 30. `_fetchResourceValue` silently swallows file-system errors

**File:** `Sources/XestiTools/FilePath/FilePath+Other.swift`

Uses `try?` which discards errors. A permission error and "value not supported"
are indistinguishable — both return `nil`.

### 31. File descriptor leak on partial `StandardIO.redirect` failure

**File:** `Sources/XestiTools/Other/StandardIO.swift`

If opening `outputPath` succeeds but opening `errorPath` fails, the `FileHandle`
created for `outputPath` is leaked.

### 32. `atexit_b` handlers accumulate per `StandardIO` instance

**File:** `Sources/XestiTools/Other/StandardIO.swift`

Every `StandardIO` instance registers a permanent `atexit_b` handler. These are
never removed, so creating many instances accumulates handlers and prevents
queue deallocation.

### 33. Hardcoded `/usr/bin/zip` and `/usr/bin/unzip` paths

**Files:**
- `Sources/XestiTools/Subprocess/ZipSubprocess.swift`
- `Sources/XestiTools/Subprocess/UnzipSubprocess.swift`

These paths may not exist on all macOS installations without Xcode or CLI tools
installed.

### 34. `Subprocess` type alias shadows `Swift.Result`

**File:** `Sources/XestiTools/Subprocess/Subprocess.swift`

The nested `typealias Result` shadows Swift's standard `Result<Success, Failure>`
within the class scope.

### 35. `Dictionary.mapKeys` / `compactMapKeys` silently lose data on key collision

**File:** `Sources/XestiTools/Extensions/Swift/Dictionary+Extensions.swift`

When the transform produces duplicate keys, earlier entries are silently
overwritten. The doc comments don't warn about this.

### 36. `Array.pop()` and `Array.top()` duplicate standard library APIs

**File:** `Sources/XestiTools/Extensions/Swift/Array+Extensions.swift`

`pop()` duplicates `popLast()` and `top()` duplicates the `last` property.

### 37. `Result.init(success:failure:noResult:)` — undocumented precedence

**File:** `Sources/XestiTools/Extensions/Swift/Result+Extensions.swift`

When both `success` and `failure` are non-nil, `failure` silently wins. This
precedence is not documented.

### 38. `CGRect` extension negative-zero check is misleading

**File:** `Sources/XestiTools/Extensions/Other/CGRect+Extensions.swift`

`if result == -0` — in Swift, `-0` as an integer literal is just `0` and
`-0.0 == 0.0` is true by IEEE 754. The intent to handle negative zero is lost.
A correct check would use `result.isZero && result.sign == .minus`.

### 39. `UUID._leftShift` boundary uses `>` instead of `>=`

**File:** `Sources/XestiTools/Extensions/Foundation/UUID+Extensions.swift`

`if shift > UInt64.bitWidth` should be `>=`. When `shift == 64`, the code relies
on Swift's specific behavior that `x << 64 == 0` for a `UInt64`.

### 40. `fileURL` force-unwraps with `require()` in `FilePath+Components`

**File:** `Sources/XestiTools/FilePath/FilePath+Components.swift`

Both branches call `.require()`, which will crash at runtime if the URL
initializer returns `nil`. While unlikely for well-formed paths, an empty or
malformed `FilePath` could trigger it.

---

## Style Issues

### 41. Doc comment typo: "od" should be "of"

**File:** `Sources/XestiTools/FilePath/FilePath+FileManager.swift` (line 242)

"Sets some or all **od** the attributes" → "Sets some or all **of** the
attributes."

### 42. Doc comments use `- Parameters` (plural) for single parameters

**File:** `Sources/XestiTools/FilePath/FilePath+FileManager.swift` (lines 69, 75, 178)

Should use `- Parameter` (singular) when documenting a single parameter.

### 43. Redundant `Equatable` conformance on `Verbosity` enum

**File:** `Sources/XestiTools/Other/Verbosity.swift`

Enums with no associated values automatically conform to `Equatable`.

### 44. Doc comment typos in `IntRepresentable` and `UIntRepresentable`

**Files:**
- `Sources/XestiTools/Representable/IntRepresentable.swift` — example shows
  `init?(intValue: String)` instead of `init?(intValue: Int)`.
- `Sources/XestiTools/Representable/UIntRepresentable.swift` — example shows
  `init?(uintValue: String)` instead of `init?(uintValue: UInt)`.

### 45. Grammar: "a unsigned integer" should be "an unsigned integer"

**File:** `Sources/XestiTools/Representable/UIntRepresentable.swift`

### 46. Redundant `String(describing:)` in Representable `description` properties

**Files:**
- `Sources/XestiTools/Representable/StringRepresentable.swift`
- `Sources/XestiTools/Representable/IntRepresentable.swift`
- `Sources/XestiTools/Representable/UIntRepresentable.swift`

`String(describing: stringValue)` is redundant when the value is already a
`String` (or trivially convertible). Simply returning the value directly is
clearer.

### 47. `CoreFoundation` imported but unused in `AsyncCommandRunner`

**File:** `Sources/XestiTools/CLI/AsyncCommandRunner.swift`

---

## Test Coverage Gaps

Out of approximately 54 source files, only 4 have corresponding test files.
The following areas have **zero** test coverage:

| Area | Untested Files |
|------|----------------|
| Subprocess/ | `Subprocess`, `BashScriptSubprocess`, `ZipSubprocess`, `UnzipSubprocess` |
| Representable/ | `StringRepresentable`, `IntRepresentable`, `UIntRepresentable` |
| Other/ | `AsyncJSONValueSequence`, `AtomicFlag`, `SequenceReader`, `StandardIO`, `EnhancedError`, `JSONFormatter`, `Miscellaneous`, `Action`, `AsyncAction`, `Reader`, `TextLocation`, `Category`, `Platform`, `Verbosity` |
| FilePath/ | `FilePath+FileManager`, `FilePath+Other`, `FilePath+Components`, `FilePath.Attributes`, `FilePath.Kind` |
| CLI/ | `CLI`, `AsyncCommandRunner`, `CommandRunner`, `ExtendedError`, `ExitCode+CLI`, `FilePath+CLI`, `URL+CLI` |
| Extensions/Foundation/ | `Data`, `URL`, `FileWrapper`, `NSError`, `RunLoop`, `NSCondition`, `NSLock`, `NSRecursiveLock` |
| Extensions/Other/ | `CGRect`, `CGPoint` |
| Extensions/Swift/ | `Array`, `Regex`, `Result`, `Optional`, `Dictionary`, `AsyncSequence` |

The existing tests (`StringExtensionsTests`, `SubstringExtensionsTests`,
`UUIDExtensionsTests`, `NSNumberExtensionsTests`) are also limited in scope —
they test only a small subset of each extension's functionality and lack edge-
case coverage.

---

## Summary

| Severity | Count |
|----------|-------|
| Critical | 6 |
| Major | 18 |
| Minor | 16 |
| Style | 7 |
| **Total** | **47** |
