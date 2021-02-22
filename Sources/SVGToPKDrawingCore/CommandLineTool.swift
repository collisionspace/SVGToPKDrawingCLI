//
//  File.swift
//  
//
//  Created by Daniel Slone on 2/17/21.
//

import Foundation

public final class CommandLineTool {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        guard arguments.count > 1 else {
            return//throw Error.missingFileName
        }

        // The first argument is the folder where the files are located
        let folderPath = arguments[1]

        // Future allow color option?
        // let color = arguments[2]

        do {
            let files = try Folder(path: folderPath).files
            let svg = SVGParser().parse(file: files.first!)
            let pkDrawing = svg.pkDrawing
            let dataRespresentation = pkDrawing.dataRepresentation()

        } catch {
            print("error \(error)")
        }
    }
}
