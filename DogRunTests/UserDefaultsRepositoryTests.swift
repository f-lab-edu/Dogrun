//
//  UserDefaultsRepositoryTests.swift
//  DogRunTests
//
//  Created by 이규관 on 2024/03/01.
//

import XCTest
@testable import DogRun

final class UserDefaultsRepositoryTests: XCTestCase {
    
    var sut: UserDefaultsRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserDefaultsRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_get_userinfo() {
        // Given
        let userInfo = UserInfo.Builder()
            .setUID("12345")
            .setEmail("example@example.com")
            .setName("John Doe")
            .setBirth("1990-01-01")
            .setArea("New York")
            .setGender(.male)
            .build()
        
        let keys = "userInfoKey"
        sut.setUserInfo(userInfo: userInfo, keys: keys)
        // When
        let retrievedUserInfo = sut.getUserInfo(keys: keys)
        // Then
        XCTAssertNotNil(retrievedUserInfo, "Retrieved user info should not be nil")
     }
    
    func test_get_doginfo() {
        // Given
        let dogInfo = DogInfo.Builder()
            .setUID("12345")
            .setName("Buddy")
            .setBirth("1990-01-01")
            .setBreed("golden")
            .setSize("M")
            .setGender(.male)
            .build()
        
        let keys = "dogInfoKey"
        sut.setDogInfo(dogInfo: dogInfo, keys: keys)

        // When
        let retrievedDogInfo = sut.getDogInfo(keys: keys)

        // Then
        XCTAssertNotNil(retrievedDogInfo, "Retrieved user info should not be nil")
     }
}
