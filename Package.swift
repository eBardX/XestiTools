// swift-tools-version: 6.3

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
                                          targets: ["XestiTools"])],
                      targets: [.target(name: "XestiTools",
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiToolsTests",
                                            dependencies: [.target(name: "XestiTools")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageModes: [.v6])
