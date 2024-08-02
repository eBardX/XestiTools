// © 2022–2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension XML {
    public final class Parser<E: Element, A: Attribute>: NSObject, XMLParserDelegate {

        // MARK: Public Nested Types

        public typealias ParsedNode = XML.Node<E, A>    // swiftlint:disable:this nesting

        // MARK: Public Initializers

        public init(_ data: Data) {
            self.baseParser = .init(data: data)
            self.pendingChildren = []
            self.pendingText = ""
            self.savedContexts = []

            super.init()

            baseParser.delegate = self
            baseParser.shouldProcessNamespaces = true
        }

        // MARK: Public Instance Methods

        public func parse() throws -> ParsedNode {
            guard  baseParser.parse(),
                   let resultNode
            else { throw resultError ?? baseParser.parserError ?? Error.internalFailure }

            return resultNode
        }

        // MARK: Private Instance Properties

        private let baseParser: XMLParser

        private var pendingChildren: [ParsedNode]
        private var pendingElement: E?
        private var pendingText: String
        private var resultError: Error?
        private var resultNode: ParsedNode?
        private var savedContexts: [(E, [ParsedNode])]
        private var unrecognizedAttribute: String?
        private var unrecognizedElement: (String, String?)?

        // MARK: Private Instance Methods

        private func _appendText(_ text: String) {
            pendingText += text
        }

        private func _endElement(_ name: String,
                                 _ uri: String) {
            guard let elem = pendingElement,
                  elem.name == name,
                  elem.uri == uri
            else { return }

            _flushText()

            let element: ParsedNode = .elem(elem, pendingChildren)

            if let context = savedContexts.popLast() {
                (pendingElement, pendingChildren) = context

                pendingChildren.append(element)
            } else {
                pendingChildren = []
                pendingElement = nil

                resultNode = element
            }
        }

        private func _flushText() {
            let text = pendingText.normalizedXMLWhitespace()

            pendingText = ""

            guard !text.isEmpty
            else { return }

            pendingChildren.append(.text(text))
        }

        private func _startElement(_ name: String,
                                   _ uri: String,
                                   _ attributes: [String: String]) {
            _flushText()

            if let elem = E(name, uri) {
                if let pendElem = pendingElement {
                    savedContexts.append((pendElem, pendingChildren))
                }

                pendingChildren = []
                pendingElement = elem

                for (name, value) in attributes {
                    if let attr = A(name) {
                        pendingChildren.append(.attr(attr, value))
                    } else {
                        unrecognizedAttribute = name

                        baseParser.abortParsing()
                    }
                }
            } else {
                unrecognizedElement = (name, uri)

                baseParser.abortParsing()
            }
        }

        // MARK: XMLParserDelegate

        public func parser(_ parser: XMLParser,
                           didEndElement elementName: String,
                           namespaceURI: String?,
                           qualifiedName qName: String?) {
            _endElement(elementName,
                        namespaceURI ?? "")
        }

        // public func parser(_ parser: XMLParser,
        //                    didEndMappingPrefix prefix: String) {
        // }

        public func parser(_ parser: XMLParser,
                           didStartElement elementName: String,
                           namespaceURI: String?,
                           qualifiedName qName: String?,
                           attributes attributeDict: [String: String]) {
            _startElement(elementName,
                          namespaceURI ?? "",
                          attributeDict)
        }

        // public func parser(_ parser: XMLParser,
        //                    didStartMappingPrefix prefix: String,
        //                    toURI namespaceURI: String) {
        // }

        // public func parser(_ parser: XMLParser,
        //                    foundAttributeDeclarationWithName attributeName: String,
        //                    forElement elementName: String,
        //                    type: String?,
        //                    defaultValue: String?) {
        // }

        public func parser(_ parser: XMLParser,
                           foundCDATA CDATABlock: Data) {
            guard let string = String(data: CDATABlock,
                                      encoding: .utf8)
            else { return }

            _appendText(string)
        }

        public func parser(_ parser: XMLParser,
                           foundCharacters string: String) {
            _appendText(string)
        }

        // public func parser(_ parser: XMLParser,
        //                    foundComment comment: String) {
        // }

        // public func parser(_ parser: XMLParser,
        //                    foundElementDeclarationWithName elementName: String,
        //                    model: String) {
        // }

        // public func parser(_ parser: XMLParser,
        //                    foundExternalEntityDeclarationWithName name: String,
        //                    publicID: String?,
        //                    systemID: String?) {
        // }

        public func parser(_ parser: XMLParser,
                           foundIgnorableWhitespace whitespaceString: String) {
            // _appendText(whitespaceString)
        }

        // public func parser(_ parser: XMLParser,
        //                    foundInternalEntityDeclarationWithName name: String,
        //                    value: String?) {
        // }

        // public func parser(_ parser: XMLParser,
        //                    foundNotationDeclarationWithName name: String,
        //                    publicID: String?,
        //                    systemID: String?) {
        // }

        // public func parser(_ parser: XMLParser,
        //                    foundProcessingInstructionWithTarget target: String,
        //                    data: String?) {

        // public func parser(_ parser: XMLParser,
        //                    foundUnparsedEntityDeclarationWithName name: String,
        //                    publicID: String?,
        //                    systemID: String?,
        //                    notationName: String?) {
        // }

        public func parser(_ parser: XMLParser,
                           parseErrorOccurred parseError: any Swift.Error) {
            let code = XMLParser.ErrorCode(rawValue: (parseError as NSError).code)
            let column = parser.columnNumber
            let line = parser.lineNumber

            switch code {
            case .delegateAbortedParseError:
                if let attr = unrecognizedAttribute {
                    resultError = .unrecognizedAttribute(attr, line, column)
                } else if let (name, uri) = unrecognizedElement {
                    resultError = .unrecognizedElement(name, uri, line, column)
                } else {
                    fallthrough // swiftlint:disable:this fallthrough
                }

            default:
                resultError = .parseFailure(parser.parserError as? (any EnhancedError), line, column)
            }
        }

        // public func parser(_ parser: XMLParser,
        //                    resolveExternalEntityName name: String,
        //                    systemID: String?) -> Data? {
        // }

        // public func parser(_ parser: XMLParser,
        //                    validationErrorOccurred validationError: Error) {
        // }

        // public func parserDidEndDocument(_ parser: XMLParser) {
        // }

        // public func parserDidStartDocument(_ parser: XMLParser) {
        // }
    }
}
