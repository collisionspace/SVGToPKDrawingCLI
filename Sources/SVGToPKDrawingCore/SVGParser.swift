//
//  File.swift
//  
//
//  Created by Daniel Slone on 2/17/21.
//

import PencilKit
import Foundation

struct SVG {
    let paths: [String]
    let size: CGSize

    var path: [SVGPath] {
        paths.map({SVGPath($0)})
    }

    var pkDrawing: PKDrawing {
        path.pkDrawing
    }

    static let none = SVG(paths: [], size: .zero)
}

class SVGParser: NSObject, XMLParserDelegate {

    private var about = [String: String]()
    private var kanji = ""
    private var paths = [String]()
    private var width = ""
    private var height = ""
    private var isKanjiSet = false

    func parse(file: File) -> SVG {
        let parser = XMLParser(contentsOf: file.url)
        parser?.delegate = self
        if parser!.parse() {
            return SVG(paths: paths, size: CGSize(width: Double(width) ?? .zero, height: Double(height) ?? .zero))
        }
        return .none
    }

    func parse(resource: String) -> SVG {
        let parser = XMLParser(contentsOf:  Bundle.main.url(forResource: resource, withExtension: "svg")!)

        parser?.delegate = self
        if parser!.parse() {
            return SVG(paths: paths, size: CGSize(width: Double(width) ?? .zero, height: Double(height) ?? .zero))
        }
        return .none
    }

    func parseAll() -> [SVG] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "svg", subdirectory: nil)
        var svgs = [SVG]()
        urls?.forEach { url in
            let parser = XMLParser(contentsOf:  url)
            parser?.delegate = self
            if parser!.parse() {
                svgs.append(SVG(paths: paths, size: CGSize(width: Double(width) ?? .zero, height: Double(height) ?? .zero)))
            }
        }
        return svgs
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        switch elementName {
        case "svg":
            if let height = attributeDict["height"] {
                self.height = height
            }
            if let width = attributeDict["width"] {
                self.width = width
            }
        case "path":
            if let d = attributeDict["d"] {
                paths.append(d)
            }
        default: break
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseError \(parseError)")
    }
}
