//
//  UIExtensionTest.swift
//  DogRunTests
//
//

import XCTest
import OSLog
@testable import DogRun

final class UIExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_ui_custom_label() {
        
        // given
        let text = "test labeltext"
        let color = UIColor.gray
        let fontsize: CGFloat = 12
        
        // when
        let customLabel = UILabel.custom(text: text)
        
        // then
        XCTAssertNotNil(customLabel, "Should not be nil")
        XCTAssertEqual(customLabel.font.pointSize, fontsize)
        XCTAssertEqual(customLabel.textColor, color)
    }
    
    func test_ui_custom_textfield() {
        
        // given
        let placeholder = "test placeholder"
        let style = UITextField.BorderStyle.roundedRect
        // when
        
        let textfield = UITextField.custom(placeholder: placeholder)
        // then
        XCTAssertNotNil(textfield, "Should not be nil")
        XCTAssertEqual(textfield.placeholder, placeholder)
        XCTAssertEqual(textfield.borderStyle, style)
        
    }
    func test_ui_custom_button() {
        
        // given
        let title = "Submit"
        let background = UIColor.blue
        
        // when
        let button = UIButton.custom(target: self, action: #selector(onClick))
 
        // then
        XCTAssertNotNil(button, "Should not be nil")
        XCTAssertEqual(button.titleLabel?.text, title)
        XCTAssertEqual(button.backgroundColor, background)
    }
}

extension UIExtensionTest {
    // 클틱 이벤트
    @objc func onClick() {
        OSLog.debug("click done")
    }
}
