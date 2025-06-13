//
//  MCPTest.swift
//  VulcanMCP
//
//  Created by Peter Liddle on 6/11/25.
//

import XCTest
import MCP
@testable import SwiftMCPServerExample
import Logging

final class MCPTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToolHandler() async throws {
        
        let echoToolParams = CallTool.Parameters(name: RegisteredTools.echo.rawValue, arguments: ["echoText": "Test Text To Echo"])
        
        let result = try await MCPServerFactory.toolsHandler(params: echoToolParams)
        
        print(result)
    }
    
//    func testJSONSchemaOutput() async throws {
//        let tool = Tool(
//            name: "weather",
//            description: "Get current weather for a location",
//            inputSchema: .object([
//                "location": .string("City name or coordinates"),
//                "units": .string("Units of measurement, e.g., metric, imperial")
//            ]),
//        )
//        
//        let encoder = JSONEncoder()
//        
//        let schema = tool.inputSchema
//        print(schema)
//        
//        let jsonRaw = try encoder.encode(tool)
//        let jsonString = String(data: jsonRaw, encoding: .ascii)
//        print(jsonString)
//    }

}
