// swift-tools-version:5.2

// © 2018–2022 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiTools",
                      platforms: [.macOS(.v10_15)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              .upToNextMajor(from: "0.4.1")),
                                     .package(url: "https://github.com/eBardX/XestiPath.git",
                                              .exact("1.0.3")),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              .exact("1.2.0"))],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiPath",
                                                                package: "XestiPath"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")])],
                      swiftLanguageVersions: [.version("5")])
