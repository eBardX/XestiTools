// swift-tools-version:5.9

// © 2018–2023 J. G. Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v14),
                                  .macOS(.v12)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.0.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "1.3.0")],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")],
                                        swiftSettings: swiftSettings)],
                      swiftLanguageVersions: [.version("5")])
