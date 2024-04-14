//  swift-tools-version: 5.8
//
//  Package.swift
//  Subtasks
//

import PackageDescription

let package = Package(
    name: "Subtasks",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", branch: "main"),
        .package(url: "https://github.com/AparokshaUI/Localized", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "Subtasks",
            dependencies: [
                .product(name: "Adwaita", package: "Adwaita"),
                .product(name: "Localized", package: "Localized")
            ],
            path: "Sources",
            resources: [
                .process("Localized.yml")
            ],
            plugins: [
                .plugin(name: "GenerateLocalized", package: "Localized")
            ]
        )
    ]
)
