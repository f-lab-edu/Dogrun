//
//  LoginViewControllerTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_viewdidlod() {
        sut?.viewDidLoad()
    }
    
    func test_signin() {
        // given
        let loginInfo = LoginInfo(uid: "12345", name: "gg lee", email: "gglee@gmail.com")
        // when
        sut?.signIn(data: loginInfo)
    }
}
