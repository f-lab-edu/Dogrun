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
          // Given
          let userId = "testUserId"
          let name = "gold"
          let birth = "2022-01-01"
          let breed = "golden retriever"
          let size = "L"
          let gender = "female"
          
          // When
          viewController.requestViewModel(userId, name, birth, breed, size, gender)
          
          // Then
          // Check if viewModel is properly initialized
          XCTAssertNotNil(viewController.viewModel, "viewModel이 초기화되지 않았습니다.")
          
          // Check if viewModel's dogInfo is properly initialized
          let dogInfo = viewController.viewModel?.dogInfo
          XCTAssertNotNil(dogInfo, "dogInfo가 초기화되지 않았습니다.")
          XCTAssertEqual(dogInfo?.ownerId, userId, "ownerId가 예상대로 설정되지 않았습니다.")
          XCTAssertEqual(dogInfo?.dogName, name, "dogName이 예상대로 설정되지 않았습니다.")
          XCTAssertEqual(dogInfo?.dogBirth, birth, "dogBirth가 예상대로 설정되지 않았습니다.")
          XCTAssertEqual(dogInfo?.dogBreed, breed, "dogBreed가 예상대로 설정되지 않았습니다.")
          XCTAssertEqual(dogInfo?.dogSize, size, "dogSize가 예상대로 설정되지 않았습니다.")
          XCTAssertEqual(dogInfo?.dogGender, gender, "dogGender가 예상대로 설정되지 않았습니다.")
      }

    // 성능 테스트 추가 메소드.
    func testPerformanceExample() throws {
        self.measure {
            // 성능을 측정하고자 하는 코드를 여기에 작성
        }
    }
}
