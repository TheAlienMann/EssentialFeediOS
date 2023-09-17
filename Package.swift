// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "EssentialFeediOS",
  platforms: [.iOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "EssentialFeediOS",
      targets: ["EssentialFeediOS"]
    ),
  ],
  dependencies: [
    .package(name: "EssentialFeed", path: "/Users/mohamadrahmani/Developer/_MyProjects/EssentialFeedDemo/EssentialFeed"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "EssentialFeediOS",
      dependencies: ["EssentialFeed"],
      path: "Sources"
    ),
    .testTarget(
      name: "EssentialFeediOSTests",
      dependencies: ["EssentialFeediOS"],
      path: "Tests"
//      resources: [.process("Resources")]
    ),
  ]
)
