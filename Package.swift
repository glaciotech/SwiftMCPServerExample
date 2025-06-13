// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMCPServerExample",
    platforms: [
        .macOS(.v13) // This is optional, specify if you have a minimum macOS version requirement
    ],
    dependencies: [
        // To use swift-sdk for MCP directly uncomment this line and copy the files in MCPHelpers to your project
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", from: "0.9.0"),
        
        .package(url: "https://github.com/swift-server/swift-service-lifecycle.git", from: "2.8.0"),
        .package(url: "https://github.com/glaciotech/mcp-swift-sdk-helpers.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "SwiftMCPServerExample",
            dependencies: [
                .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),
                
                // Uncomment when using swift-sdk for mcp directly
//                .product(name: "MCP", package: "swift-sdk"),  // Replace "SwiftSDK" with the actual library name if different
                
                // Comment this line when using swift-sdk directly
                .product(name: "MCPHelpers", package: "mcp-swift-sdk-helpers")
            ]
        ),
        .testTarget(
            name: "SwiftMCPServerExampleTests",
            dependencies: [
                "SwiftMCPServerExample",
                .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),

                // Uncomment when using swift-sdk for mcp directly
//                .product(name: "MCP", package: "swift-sdk"),  // Replace "SwiftSDK" with the actual library name if different
                
                // Comment this line when using swift-sdk directly
                .product(name: "MCPHelpers", package: "mcp-swift-sdk-helpers")
            ],
            path: "Tests"
        )
    ]
)
