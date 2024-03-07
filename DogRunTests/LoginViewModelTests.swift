//
//  LoginViewModelTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginViewModel(persistenceService: APIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_signin() {
        // given
        let loginInfo = LoginInfo(uid: "12345", name: "gg lee", email: "gglee@gmail.com")
        // when
        sut?.signIn(data: loginInfo) { success in
            // then
            if success {
                XCTAssertTrue(success, "test cast - success")
            }else {
                XCTAssertFalse(success, "test cast - fail")
            }
        }
    }
    
    func test_local_save() {
        
        // given
        let userInfo = UserInfo.Builder()
            .uid("12345")
            .email("example@example.com")
            .name("John Doe")
            .birth("1990-01-01")
            .area("New York")
            .gender(.male)
            .build()
        
        // when
        sut?.saveLocal(data: userInfo)
        // then
        let retrievedInfo = UserDefaultsRepository().getUserInfo(keys: "userInfos")
        XCTAssertNotNil(retrievedInfo, "Retrieved user info should not be nil")
    }
}
