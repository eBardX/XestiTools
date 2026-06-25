// swift-tools-version: 6.2

// © 2018–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

let package = Package(name: "XestiTools",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiTools",
                                          targets: ["XestiTools"]),
                                 .library(name: "XestiToolsCore",
                                          targets: ["XestiToolsCore"])],
                      dependencies: [.package(url: "https://github.com/apple/swift-argument-parser.git",
                                              .upToNextMajor(from: "1.8.0")),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              .upToNextMajor(from: "4.0.0")),
                                     .package(url: "https://github.com/weichsel/ZIPFoundation.git",
                                              .upToNextMajor(from: "0.9.0"))],
                      targets: [.target(name: "XestiTools",
                                        dependencies: [.target(name: "XestiToolsCore"),
                                                       .product(name: "ArgumentParser",
                                                                package: "swift-argument-parser"),
                                                       .product(name: "ZIPFoundation",
                                                                package: "ZIPFoundation")],
                                        swiftSettings: swiftSettings),
                                .target(name: "XestiToolsCore",
                                        dependencies: [.product(name: "XestiText",
                                                                package: "XestiText")],
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiToolsCoreTests",
                                            dependencies: [.target(name: "XestiToolsCore")],
                                            swiftSettings: swiftSettings),
                                .testTarget(name: "XestiToolsTests",
                                            dependencies: [.target(name: "XestiTools")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageModes: [.v6])
