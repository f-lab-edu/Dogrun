//
//  UserViewModelTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class UserViewModelTests: XCTestCase {

    var sut: UserInfoViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserInfoViewModel(persistenceService: APIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_update() {
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
        sut?.update(data: userInfo) { success in
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
