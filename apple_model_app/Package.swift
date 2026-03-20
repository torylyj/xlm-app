// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppleModelApp",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "MLXCore",
            targets: ["MLXCore"],
            dependencies: [
                .package(url: "https://github.com/ml-explore/mlx-swift", from: "1.0.0")
            ]
        ),
        .executable(
            name: "AppleModelApp",
            targets: ["AppleModelApp"]
        )
    ],
    targets: [
        .target(
            name: "AppleModelApp"
        ),
        .target(
            name: "MLXCore",
            dependencies: [
                "MLXCore"
            ]
        ),
        .testTarget(
            name: "AppleModelAppTests",
            dependencies: ["AppleModelApp"]
        )
    ]
)
