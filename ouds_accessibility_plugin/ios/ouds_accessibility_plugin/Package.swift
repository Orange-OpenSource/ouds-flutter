// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ouds_accessibility_plugin",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "ouds-accessibility-plugin", targets: ["ouds_accessibility_plugin"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "ouds_accessibility_plugin",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
