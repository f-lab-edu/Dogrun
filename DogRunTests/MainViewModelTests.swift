//
//  MainViewModelTests.swift
//  DogRunTests
//
//  Created by 이규관 on 2024/03/03.
//

import XCTest
@testable import DogRun

final class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainViewModel(persistenceService: APIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
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
        
        let dogInfo = DogInfo.Builder()
            .setUID("12345")
            .setName("Buddy")
            .setBirth("1990-01-01")
            .setBreed("golden")
            .setSize("M")
            .setGender(.male)
            .build()
        
        // when
        sut.saveLocal(dogData: dogInfo, userData: userInfo)
        // then
        let retrievedInfo = UserDefaultsRepository().getDogInfo(keys: "dogInfos")
        XCTAssertNotNil(retrievedInfo, "Retrieved user info should not be nil")
    }
}
