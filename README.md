### Windsurf integration
Add the `swift-mcp-server-example` json fragment to your MCP Server config file in Windsurf, replacing {XCODE_BUILD_FOLDER} with the build folder for your project.
This can be found by going to Product->Copy Build Folder Path in Xcode. Once added Click the "Refresh" button in Windsurf to discover the new MCP Server.
                                                                                                                                                        
#### Notes
- Make sure you have built the project first.
- Sometimes Windsurf can have problems in that case close Windsurf. Kill the MCP server if it's running in Activity Monitor and relaunch Windsurf


```json
{
  "mcpServers": {
    .
    .
    . ,
    "swift-mcp-server-example": {
      "command": "{XCODE_BUILD_FOLDER}/Products/Debug/SwiftMCPServerExample",
      "args": [],
      "env": {}
    }
  }
}
```
