// swift-tools-version:5.6

// © 2018–2022 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiTools",
                      platforms: [.macOS(.v11)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.0.0"),
                                     .package(url: "https://github.com/eBardX/XestiPath.git",
                                              from: "1.1.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "1.2.0")],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiPath",
                                                                package: "XestiPath"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")])],
                      swiftLanguageVersions: [.version("5")])
