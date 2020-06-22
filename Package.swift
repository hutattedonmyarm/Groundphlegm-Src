// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Groundphlegm",
    platforms: [.macOS(.v10_12)],
    products: [
        .executable(name: "Groundphlegm", targets: ["Groundphlegm"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "Groundphlegm",
            dependencies: ["Publish"]
        )
    ]
)
