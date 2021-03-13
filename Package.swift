// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STOKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "STOKit", type: .static, targets: ["STOKit"]),
        .executable(name: "EpisodeLister", targets: ["EpisodeLister"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package(name: "SwiftSoup", url: "https://github.com/scinfu/SwiftSoup.git", from: "2.3.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "STOKit",
            dependencies: [
                // "SwiftSoup"
            ],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "STOKitTests",
            dependencies: ["STOKit"]),
        .executableTarget(
            name: "EpisodeLister",
            dependencies: ["STOKit"],
            swiftSettings: [
                .unsafeFlags([
                    "-parse-as-library"
                ])
            ]
        ),
    ]
)
