//
//  OSLogMethodTest.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun
import OSLog

final class OSLogMethodTest: XCTestCase {
      
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_oslog_method_debug() {
        
        // given
        let message = "test case - debug message"
        // when
        OSLog.debug(message)
    }
    
    func test_oslog_method_info() {
        
        // given
        let message = "test case - info message"
        // when
        OSLog.info(message)
    }
    
    func test_oslog_method_error() {
        
        // given
        let message = "test case - error message"
        // when
        OSLog.error(message)
    }
}
