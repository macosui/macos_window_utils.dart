// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "macos_window_utils",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "macos-window-utils", targets: ["macos_window_utils"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "macos_window_utils",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        )
    ]
)