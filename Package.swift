// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SVGToPKDrawing",
    platforms: [
        .macOS(.v11),
    ],
    targets: [
        .target(
            name: "SVGToPKDrawing",
            dependencies: ["SVGToPKDrawingCore"]
        ),
        .target(name: "SVGToPKDrawingCore")
    ]
)
