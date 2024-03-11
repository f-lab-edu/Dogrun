//
//  UtilsTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class UtilsTests: XCTestCase {
     

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_show_alert() {
        
        // given
        let vc = UIViewController()
        let message = "test cast - alert test"
        
        // when
        let alert = Utils.showAlert(message: message, view: vc)
        
        // then
        XCTAssertNotNil(alert, "Should not be nil")
    }
    
    func test_valid_code_success() {
        
        // given
        let code = 200
        // when
        let validSuccess = Utils.isSuccessResponse(code: code)
        // then
        XCTAssertNotNil(validSuccess, "Should not be nil")
        XCTAssertTrue(validSuccess,"valid success code")
        
    }
    
    func test_valid_code_fail() {
        
        // given
        let code = 500
        // when
        let validFail = Utils.isSuccessResponse(code: code)
        // then
        XCTAssertNotNil(validFail, "Should not be nil")
        XCTAssertFalse(validFail,"valid fail code")
        
    }
}
