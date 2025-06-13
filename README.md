# Swift MCP Server Example

A simple example of a Model Context Protocol (MCP) server implemented in Swift. This project demonstrates how to create custom tools that can be used by AI systems like Cascade in Windsurf.

## What is MCP?

MCP (Model Context Protocol) is a standard that allows AI systems like large language models (LLMs) to interact with external tools and services. By implementing an MCP server, you can extend AI capabilities with custom functionality that can be accessed through a standardized interface.

## Features

- Echo tool: Echoes back any text sent to it
- Random Selector tool: Selects a random element from an array of integers

## Prerequisites

- Xcode 15 or later
- Swift 6.0 or later
- Basic knowledge of Swift and SPM (Swift Package Manager)
- Windsurf (for integration testing)

## Building the Project

### Using Xcode

1. Open the project in Xcode by double-clicking the `Package.swift` file or using `xed .` in the terminal
2. Select the 'SwiftMCPServerExample' scheme from the scheme selector
3. Click the Build button (▶️) or press Cmd+B to build the project

### Using Command Line

```bash
# Navigate to the project directory
cd /path/to/SwiftMCPServerExample

# Build the project
swift build

# Run the server (optional)
.build/debug/SwiftMCPServerExample
```

## Windsurf Integration

To use this MCP server with Windsurf:

1. Build the project first using one of the methods above
2. Add the `swift-mcp-server-example` JSON fragment to your MCP Server config file in Windsurf:

```json
{
  "mcpServers": {
    ...,
    "swift-mcp-server-example": {
      "command": "{XCODE_BUILD_FOLDER}/Products/Debug/SwiftMCPServerExample",
      "args": [],
      "env": {}
    }
  }
}
```

3. Replace `{XCODE_BUILD_FOLDER}` with the build folder for your project. This can be found by going to Product → Copy Build Folder Path in Xcode.
4. Click the "Refresh" button in Windsurf to discover the new MCP Server.

![Windsurf MCP Server Configuration](https://cdn.hashnode.com/res/hashnode/image/upload/v1749839738279/780e0c82-6e23-4f72-8217-fdd87c45242d.png)

## Using the MCP Tools in Windsurf

Once your MCP server is running and connected to Windsurf, you can interact with it through Cascade:

### Using the Random Selector Tool

You can ask Cascade to generate a list of random numbers and use the selectRandom tool to pick one:

![MCP Server in Action - Random Selector Tool](https://cdn.hashnode.com/res/hashnode/image/upload/v1749839678027/7645a096-c68d-4161-a087-f2f432aab6b2.png)

### Using the Echo Tool

You can also use the echo tool to have text echoed back to you:

![MCP Server in Action - Echo Tool](https://cdn.hashnode.com/res/hashnode/image/upload/v1749839714706/c41376bc-35e0-4c94-a26b-a4ef53e235c2.png)

## Troubleshooting

If you encounter issues with your MCP server in Windsurf:

- Make sure you've built the project first
- Try closing Windsurf
- Kill any running MCP server processes in Activity Monitor
- Relaunch Windsurf

## Step-by-Step Guide

For a detailed, step-by-step guide on how to build this project from scratch, check out our blog post:

[Building a MCP Server in Swift: A Step-by-Step Guide](https://blog.glacio.tech/building-a-mcp-server-in-swift-a-step-by-step-guide)

## License

This project is available under the MIT License. See the LICENSE file for more info.
