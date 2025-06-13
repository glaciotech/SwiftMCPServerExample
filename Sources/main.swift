// The Swift Programming Language
// https://docs.swift.org/swift-book


import MCP
import ServiceLifecycle
import Foundation
import Logging

final class App: Sendable {
    
    // Create a logging object we'll hand to other parts of the project
    let log = {
        var logger = Logger(label: "tech.glacio.mcpserverexample")
        logger.logLevel = .debug
        return logger
    }()
    
    /// Create and start our  MCP service, we make use of a ServiceGroup to handle launching and shutting down the server
    func start() async throws {
        
        log.info("App has started")
        
        // Create the configured server with registered Tools and the MCP service
        let transport = StdioTransport(logger: log)
        let server = await MCPServerFactory.makeServer(with: log)
        let mcpService = MCPService(server: server, transport: transport)

        // Create service group with signal handling
        let serviceGroup = ServiceGroup(services: [mcpService],
                                        gracefulShutdownSignals: [.sigterm, .sigint],
                                        logger: log)
            
        // Run the service group - this blocks until shutdown
        try await serviceGroup.run()
    }
}

// Start the app. You could also do this with `@main` by creating an App.swift and adding the `@main` annotation and calling start() from there
try! await App().start()

