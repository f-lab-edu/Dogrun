//
//  DoginfoViewControllerTests.swift
//  DogRunTests
//
//  Created by 이규관 on 2024/01/25.
//

import XCTest

@testable import DogRun

final class DoginfoViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    var viewController: DogInfoViewController!
      
    override func setUp() {
        super.setUp()

        viewController = DogInfoViewController()
        // viewController의 viewDidLoad()를 호출하여 뷰가 로드되도록 설정
        viewController.loadView()
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    } 

    // 성능 테스트 추가 메소드.
    func testPerformanceExample() throws {
        self.measure {
            // 성능을 측정하고자 하는 코드를 여기에 작성
        }
    }
}
