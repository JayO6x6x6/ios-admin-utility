// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "IOSAdminUtility",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "IOSAdminUtility",
            targets: ["IOSAdminUtility"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "IOSAdminUtility",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "IOSAdminUtilityTests",
            dependencies: ["IOSAdminUtility"],
            path: "Tests"
        ),
    ]
)
