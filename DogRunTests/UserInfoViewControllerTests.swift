//
//  UserInfoViewControllerTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class UserInfoViewControllerTests: XCTestCase {
    
    var sut: UserInfoViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserInfoViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_viewdidlod() {
        sut?.viewDidLoad()
    }
}
