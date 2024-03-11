//
//  APIEdnpointType.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class APIEdnpointTypeTests: XCTestCase {
    
    let host = EtcKeys.baseUrl.rawValue.localized

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_api_endpoint_signin () {
        
        var apiUrl = SignIn().urlString
        
        // then
        XCTAssertNotNil(apiUrl, "API url should not be nil")
        XCTAssertEqual(apiUrl, "\(host)/signIn")
    }
    
    func test_api_endpoint_update_user () {
        
        var apiUrl = UpdateUser().urlString
        
        // then
        XCTAssertNotNil(apiUrl, "API url should not be nil")
        XCTAssertEqual(apiUrl, "\(host)/updateUser")
    }
    
    func test_api_endpoint_update_dog () {
        
        var apiUrl = UpdateDog().urlString
        
        // then
        XCTAssertNotNil(apiUrl, "API url should not be nil")
        XCTAssertEqual(apiUrl, "\(host)/updateDog")
        
    }
}
