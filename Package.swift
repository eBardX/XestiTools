// swift-tools-version:5.8

// © 2018–2023 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v14),
                                  .macOS(.v11)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.0.0"),
                                     .package(url: "https://github.com/eBardX/XestiPath.git",
                                              from: "1.2.1"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "1.2.2")],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiPath",
                                                                package: "XestiPath"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")])],
                      swiftLanguageVersions: [.version("5")])
