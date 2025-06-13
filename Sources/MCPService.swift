//
//  MCPService.swift
//  VulcanMCP
//
//  Created by Peter Liddle on 5/27/25.
//
import MCP
import ServiceLifecycle
import Logging

struct MCPService: Service {
    
    let server: Server
    let transport: StdioTransport
    
    init(server: Server, transport: StdioTransport) {
        self.server = server
        self.transport = transport
    }
    
    func run() async throws {
        // Start the server
        try await server.start(transport: transport)

        // Keep running until external cancellation
        try await Task.sleep(for: .seconds(10000)) 
    }

    func shutdown() async throws {
        // Gracefully shutdown the server
        await server.stop()
    }
}

struct WeatherDataType {
    var temperature: Double
    var conditions: String
}

func getWeatherData(location: String, units: String) -> WeatherDataType {
    return WeatherDataType(temperature: 80, conditions: "Sunny")
}

func evaluateExpression(_ expression: String) -> String {
    "Evaluated \(expression)"
}
