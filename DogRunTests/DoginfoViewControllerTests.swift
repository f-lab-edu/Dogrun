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

    func testRequestViewModel() {
        // Given : 강아지 정보 테스트
        let userId = "testUserId"
        let name = "gold"
        let birth = "2022-01-01"
        let breed = "golden retriever"
        let size = "L"
        let gender = "female"

        // When : 뷰컨트롤러 내 메소드 테스트
        viewController.requestViewModel(userId, name, birth, breed, size, gender)

        // Then : 메소드에 대한 테스트 결과 체크
        let dogInfo = viewController.viewModel?.dogInfo
        XCTAssertNotNil(viewController.viewModel, "viewModel이 초기화되지 않았습니다.")
        XCTAssertNotNil(dogInfo, "dogInfo가 초기화되지 않았습니다.")
        XCTAssertEqual(dogInfo?.uid, userId, "ownerId가 예상대로 설정되지 않았습니다.")
      }

    // 성능 테스트 추가 메소드.
    func testPerformanceExample() throws {
        self.measure {
            // 성능을 측정하고자 하는 코드를 여기에 작성
        }
    }
}
