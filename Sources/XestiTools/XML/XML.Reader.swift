// © 2022–2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension XML {
    public class Reader<E: Element, A: Attribute>: NSObject, XMLParserDelegate {

        // MARK: Private Initializers

        private init(parser: XMLParser) {
            self.parser = parser

            super.init()

            parser.delegate = self
            parser.shouldProcessNamespaces = true
        }

        // MARK: Private Instance Properties

        private let parser: XMLParser

        private var pendingChildren: [ReaderNode] = []
        private var pendingElement: E?
        private var pendingText: String = ""
        private var result: ReaderNode?
        private var savedContexts: [(E, [ReaderNode])] = []

        // MARK: Private Instance Methods

        private func _appendText(_ text: String) {
            pendingText += text
        }

        private func _endElement(_ name: String,
                                 _ uri: String?) {
            guard let elem = pendingElement,
                  elem.name == name,
                  elem.uri == uri
            else { return }

            _flushText()

            let element: ReaderNode = .element(elem, pendingChildren)

            if let context = savedContexts.popLast() {
                (pendingElement, pendingChildren) = context

                pendingChildren.append(element)
            } else {
                pendingChildren = []
                pendingElement = nil

                result = element
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
                                   _ uri: String?,
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
                        pendingChildren.append(.attribute(attr, value))
                    } else {
                        parser.abortParsing()
                    }
                }
            } else {
                parser.abortParsing()
            }
        }

        // MARK: XMLParserDelegate Instance Methods

        public func parser(_ parser: XMLParser,
                           didEndElement elementName: String,
                           namespaceURI: String?,
                           qualifiedName qName: String?) {
            _endElement(elementName,
                        namespaceURI)
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
                          namespaceURI,
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
            guard
                let string = String(data: CDATABlock,
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

        // public func parser(_ parser: XMLParser,
        //                    parseErrorOccurred parseError: Error) {
        // }

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

// MARK: -

extension XML.Reader {

    // MARK: Public Nested Types

    public typealias ReaderNode   = XML.Node<E, A>
    public typealias ReaderResult = Result<ReaderNode, XML.Error>

    // MARK: Public Initializers

    public convenience init?(contentsOf url: URL) {
        guard let parser = XMLParser(contentsOf: url)
        else { return nil }

        self.init(parser: parser)
    }

    public convenience init(data: Data) {
        self.init(parser: XMLParser(data: data))
    }

    public convenience init(stream: InputStream) {
        self.init(parser: XMLParser(stream: stream))
    }

    // MARK: Public Instance Methods

    public func read() -> ReaderResult {
        if parser.parse(),
           let result = result {
            return .success(result)
        } else {
            return .failure(.parseFailure(parser.parserError as (any EnhancedError)?))
        }
    }
}
