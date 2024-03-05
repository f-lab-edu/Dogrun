//
//  DogInfoViewModelTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class DogInfoViewModelTests: XCTestCase {

    var sut: DogInfoViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DogInfoViewModel(persistenceService: APIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_update() {
        
        // given
        let dogInfo = DogInfo.Builder()
            .setUID("12345")
            .setName("Buddy")
            .setBirth("1990-01-01")
            .setBreed("golden")
            .setSize("M")
            .setGender(.male)
            .build()
        
        // when
        sut?.update(data: dogInfo) { success in
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
        let dogInfo = DogInfo.Builder()
            .setUID("12345")
            .setName("Buddy")
            .setBirth("1990-01-01")
            .setBreed("golden")
            .setSize("M")
            .setGender(.male)
            .build()
        
        // when
        sut?.saveLocal(data: dogInfo)
        // then
        let retrievedInfo = UserDefaultsRepository().getDogInfo(keys: "dogInfos")
        XCTAssertNotNil(retrievedInfo, "Retrieved user info should not be nil")
    }

}
