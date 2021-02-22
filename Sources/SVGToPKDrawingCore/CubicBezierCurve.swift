//
//  File.swift
//  
//
//  Created by Daniel Slone on 2/17/21.
//

import Foundation
import CoreGraphics

// creating my own https://developer.apple.com/documentation/uikit/uibezierpath/1624357-addcurve
// based on the equation here https://www.freecodecamp.org/news/nerding-out-with-bezier-curves-6e3c0bc48e2f/
//
// t = 4 is about as low as one should go, higher the t the smoother the line will be
func cubicBezierCurve(leftAnchor: CGPoint, leftControlPoint: CGPoint, rightAnchor: CGPoint, rightControlPoint: CGPoint, points t: Int = 4) -> [CGPoint] {

    let p0x = leftAnchor.x
    let p1x = leftControlPoint.x
    let p2x = rightControlPoint.x
    let p3x = rightAnchor.x

    let p0y = leftAnchor.y
    let p1y = leftControlPoint.y
    let p2y = rightControlPoint.y
    let p3y = rightAnchor.y


    let points = (0...t).map { value -> CGPoint in
        let t = CGFloat(value) / CGFloat(t)

        let cubed = pow(CGFloat(1 - t), CGFloat(3))

        let squared = 3 * pow(CGFloat(1 - t), CGFloat(2)) * t

        let secondLast = 3 * (1 - t) * pow(CGFloat(t), CGFloat(2))

        let last = pow(CGFloat(t), CGFloat(3))

        let x1: CGFloat = (cubed * p0x) + (squared * p1x)
        let x2: CGFloat = (secondLast * p2x) + (last * p3x)

        let y1: CGFloat = (cubed * p0y) + (squared * p1y)
        let y2: CGFloat = (secondLast * p2y) + (last * p3y)

        return CGPoint(x: x1 + x2, y: y1 + y2)
    }
    return points
}
