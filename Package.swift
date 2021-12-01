// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JFLib",
    platforms: [
        .iOS(.v15), .macOS(.v12)
    ],
    products: [
        .library(
            name: "JFLib.Combine",
            targets: ["JFLib.Combine"]),
        .library(
            name: "JFLib.Services",
            targets: ["JFLib.Services"]),
        .library(
            name: "JFLib.Mediator",
            targets: ["JFLib.Mediator"]),
    ],
    dependencies: [
        .package(name: "Dip", url: "https://github.com/AliSoftware/Dip", from: "7.1.1"),
    ],
    targets: [
        .target(
            name: "JFLib.Combine",
            dependencies: []),
        .target(
            name: "JFLib.Services",
            dependencies: ["Dip"]),
        .testTarget(
            name: "JFLib.ServicesTests",
            dependencies: ["JFLib.Services"]),
        .target(
            name: "JFLib.Mediator",
            dependencies: ["JFLib.Services"]),
        .testTarget(
            name: "JFLib.MediatorTests",
            dependencies: ["JFLib.Mediator"]),
    ]
)
