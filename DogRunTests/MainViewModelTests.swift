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
            .uid("12345")
            .email("example@example.com")
            .name("John Doe")
            .birth("1990-01-01")
            .area("New York")
            .gender(.male)
            .build()
        
        let dogInfo = DogInfo.Builder()
            .uid("12345")
            .name("Buddy")
            .birth("1990-01-01")
            .breed("golden")
            .size("M")
            .gender(.male)
            .build()
        
        // when
        sut.saveLocal(dogData: dogInfo, userData: userInfo)
        // then
        let retrievedInfo = UserDefaultsRepository().getDogInfo(keys: "dogInfos")
        XCTAssertNotNil(retrievedInfo, "Retrieved user info should not be nil")
    }
}
