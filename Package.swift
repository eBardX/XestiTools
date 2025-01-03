// swift-tools-version:5.11

// © 2018–2024 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v15),
                                  .macOS(.v13)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.0.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "2.0.0")],
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
