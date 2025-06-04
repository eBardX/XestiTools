// swift-tools-version: 5.10

// © 2018–2025 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.5.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "3.0.0")],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")],
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiToolsTests",
                                            dependencies: [.target(name: "XestiTools")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageVersions: [.version("5")])
