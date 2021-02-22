//
//  File.swift
//  
//
//  Created by Daniel Slone on 2/22/21.
//

import CoreGraphics
import PencilKit

extension SVGPath {

    var cgPoints: [CGPoint] {
        var points = [CGPoint]()
        var endPoint: CGPoint = .zero
        if let startPointCommand = commands.filter({ $0.type == .move }).first {
            let startPoint = CGPoint(x: startPointCommand.point.x, y: startPointCommand.point.y)
            endPoint = startPoint

            points.append(startPoint)
        }
        commands.forEach { command in
            if case .cubeCurve = command.type {
                print(command)
                let cube = cubicBezierCurve(
                    leftAnchor: endPoint,
                    leftControlPoint: command.control1,
                    rightAnchor: command.point,
                    rightControlPoint: command.control2
                )
                endPoint = command.point
                points += cube
            }
        }
        return points
    }
}

extension Array where Element == SVGPath {

    var paths: [CGPoint] {
        flatMap(\.cgPoints)
    }

    var pkDrawing: PKDrawing {
        var strokes = [PKStroke]()

        forEach { path in
            let cgpoints = path.cgPoints.map { value in
                PKStrokePoint(
                    location: value,
                    timeOffset: .zero,
                    size: CGSize(width: 4, height: 4),
                    opacity: 1,
                    force: 1,
                    azimuth: 0.81,
                    altitude: 0.81
                )
            }

            let strokePath = PKStrokePath(
                controlPoints: cgpoints,
                creationDate: Date()
            )
            let stroke = PKStroke(
                ink: PKInk(.pen, color: .black),
                path: strokePath
            )
            strokes.append(stroke)
        }

        // illegal instructions
        let drawing = PKDrawing(strokes: strokes)

//        // works
//        var drawing = PKDrawing(strokes: [])
//        print(strokes)
//        // illegal instructions
//        drawing.strokes = strokes
        return drawing
    }
}
