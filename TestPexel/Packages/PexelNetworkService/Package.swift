// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let packageName = "PexelNetworkService"

private enum Targets: String, CaseIterable {
    case service = "CustomNetworkService"
}

let package = Package(
    name: packageName,
    products: [
        .library(
            name: packageName,
            targets: Targets.allCases.map(\.rawValue)),
    ],
    targets: [
        .target(name: Targets.service.rawValue),
        .testTarget(
            name: "NetworkServiceTests",
            dependencies: [.targetItem(name: Targets.service.rawValue, condition: nil)]),
    ]
)
