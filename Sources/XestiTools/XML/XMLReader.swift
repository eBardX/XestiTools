// © 2022 J. G. Pusey (see LICENSE.md)

import Foundation

public class XMLReader: NSObject {

    // MARK: Private Initializers

    private init(parser: XMLParser) {
        self.parser = parser

        super.init()

        parser.delegate = self
        parser.shouldProcessNamespaces = true
    }

    // MARK: Private Instance Properties

    private let parser: XMLParser

    private var pendingChildren: [XMLNode] = []
    private var pendingName: String = ""
    private var pendingText: String = ""
    private var pendingURI: String?
    private var result: XMLNode?
    private var savedContexts: [(String, String?, [XMLNode])] = []

    // MARK: Private Instance Methods

    private func _appendText(_ text: String) {
        pendingText += text
    }

    private func _endElement(_ name: String,
                             _ uri: String?) {
        guard pendingName == name,
              pendingURI == uri
        else { return }

        _flushText()

        let element = XMLNode.element(name,
                                      uri,
                                      pendingChildren)

        if let context = savedContexts.popLast() {
            (pendingName, pendingURI, pendingChildren) = context

            pendingChildren.append(element)
        } else {
            pendingChildren = []
            pendingName = name
            pendingURI = uri

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

        if !pendingName.isEmpty {
            savedContexts.append((pendingName, pendingURI, pendingChildren))
        }

        pendingChildren = []
        pendingName = name
        pendingURI = uri

        for (name, value) in attributes {
            pendingChildren.append(.attribute(name, value))
        }
    }
}

// MARK: - Public Extension

extension XMLReader {
    public typealias ReadResult = Result<XMLNode, XMLError>

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

    public func read() -> ReadResult {
        if parser.parse(),
           let result = result {
            return .success(result)
        } else {
            return .failure(.parseFailed(parser.parserError))
        }
    }
}

// MARK: - XMLParserDelegate

extension XMLReader: XMLParserDelegate {

    // MARK: Public Instance Methods

    public func parser(_ parser: XMLParser,
                       didEndElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?) {
        _endElement(elementName,
                    namespaceURI)
    }

    public func parser(_ parser: XMLParser,
                       didStartElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?,
                       attributes attributeDict: [String: String]) {
        _startElement(elementName,
                      namespaceURI,
                      attributeDict)
    }

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

    public func parser(_ parser: XMLParser,
                       foundIgnorableWhitespace whitespaceString: String) {
        // _appendText(whitespaceString)
    }

    // public func parserDidEndDocument(_ parser: XMLParser) {
    // }

    // public func parserDidStartDocument(_ parser: XMLParser) {
    // }
}
