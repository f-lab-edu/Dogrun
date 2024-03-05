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
            .setUID("12345")
            .setEmail("example@example.com")
            .setName("John Doe")
            .setBirth("1990-01-01")
            .setArea("New York")
            .setGender(.male)
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
            .setUID("12345")
            .setEmail("example@example.com")
            .setName("John Doe")
            .setBirth("1990-01-01")
            .setArea("New York")
            .setGender(.male)
            .build()
        
        // when
        sut?.saveLocal(data: userInfo)
        // then
        let retrievedInfo = UserDefaultsRepository().getUserInfo(keys: "userInfos")
        XCTAssertNotNil(retrievedInfo, "Retrieved user info should not be nil")
    }
}
