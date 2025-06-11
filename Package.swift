// swift-tools-version: 6.1

// © 2018–2025 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              from: "1.5.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              branch: "swift-6-support")],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "XestiText",
                                                                package: "XestiText")]),
                                .testTarget(name: "XestiToolsTests",
                                            dependencies: [.target(name: "XestiTools")])],
                      swiftLanguageModes: [.version("6")])
