// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IntrospectUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "IntrospectUI", targets: ["IntrospectUI"]),
    ],
    targets: [
        .target(name: "IntrospectUI"),
//        .testTarget(name: "IntrospectUITests", dependencies: ["IntrospectUI"]),
    ]
)
