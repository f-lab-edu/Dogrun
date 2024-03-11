//
//  DogInfoViewControllerTests.swift
//  DogRunTests
//
//

import XCTest
@testable import DogRun

final class DogInfoViewControllerTests: XCTestCase {

    var sut: DogInfoViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DogInfoViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_viewdidlod() {
        sut?.viewDidLoad()
    }

}
