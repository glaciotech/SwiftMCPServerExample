//
//  MCPServerFactory.swift
//  SwiftMCPServerExample
//
//  Created by Peter Liddle on 6/12/25.
//

import Foundation
import SwiftyJsonSchema
import ServiceLifecycle
import MCP
import Logging
import MCPHelpers

// We make use of SwiftyJsonSchema to generate the JSON schema that informs the LLM of how to structure the tool call
struct EchoToolInput: ProducesJSONSchema, ParamInitializable {
    static let exampleValue = EchoToolInput(echoText: "Echo...")
    
    @SchemaInfo(description: "Text to send to the service that will be echoed back")
    var echoText: String = ""
}

struct PickRandomToolInput: ProducesJSONSchema, ParamInitializable {
    static let exampleValue = PickRandomToolInput(ints: [5, 4, 6, 7, 123, 8411])
    
    @SchemaInfo(description: "An array of integers to select one at random from")
    var ints: [Int]? = nil
}


enum RegisteredTools: String {
    case echo
    case selectRandom
}

/// MCPSeverFactory creates and configures our server with the example Tools and Prompts
class MCPServerFactory {
    
    /// This creates a new instance of a configured MCP server with our Tools ready to go
    static func makeServer(with logger: Logger) async -> Server {
        // Create our server
        let server = Server(name: "ExampleSwiftMCPServer",
                            version: "1.0",
                            capabilities: .init(logging: Server.Capabilities.Logging(),
                                                resources: .init(subscribe: true, listChanged: true),
                                                tools: .init(listChanged: true)
        ))
        
        // Register the tools
        await registerTools(on: server)
        
        // Setup the code to handle the tool logic when we receive a request for that tool
        await server.withMethodHandler(CallTool.self, handler: toolsHandler)
        
        return server
    }
    
    private static func registerTools(on server: Server) async {
        /// Register a tool list handler
        await server.withMethodHandler(ListTools.self) { _ in
            
            // Define 2 simple tools an echo tool, that just returns whatever the LLM sends
            // and a stock price tool that graps the latest stock price from Yahoo. We make use of
            let tools = [
                Tool(
                    name: RegisteredTools.echo.rawValue,
                    description: "Echo back any text that was sent",
                    inputSchema: try .produced(from: EchoToolInput.self)
                ),
                Tool(
                    name: RegisteredTools.selectRandom.rawValue,
                    description: "Takes in a collection of numbers or strings and picks one at random",
                    inputSchema: try .produced(from: PickRandomToolInput.self)
                )
            ]
            return .init(tools: tools)
        }
    }

    static func toolsHandler(params: CallTool.Parameters) async throws -> CallTool.Result {
        let unknownToolError = CallTool.Result(content: [.text("Unknown tool")], isError: true)
        
        // Convert tool name to our enum
        guard let tool = RegisteredTools(rawValue: params.name) else {
            return unknownToolError
        }
        
        switch tool {
        case RegisteredTools.echo:
            let input = try EchoToolInput(with: params)
            let result = echoHandler(input.echoText)
            return .init(
                content: [.text("You sent: \(result)")],
                isError: false
            )
            
        case RegisteredTools.selectRandom:
            let input = try PickRandomToolInput(with: params)
            let result = self.pickRandomNumberHandler(input.ints)
            return .init(
                content: [.text("I picked: \(result)")],
                isError: false
            )
        }
    }
    
    //MARK: - Tool handlers that implement the actual individual tool logic

    private static func echoHandler(_ text: String) -> String {
        return text
    }

    private static func pickRandomNumberHandler(_ numbers: [Int]?) -> Int {
        guard let numbers = numbers else {
            return .zero
        }
        return numbers.randomElement() ?? .zero
    }
}
