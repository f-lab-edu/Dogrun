//
//  UI+Extension.swift
//  DogRun
//
import UIKit

extension UILabel {
    // 항목 라밸의 생성
    static func custom(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
}

extension UITextField {
    // form 화면에 사용되는 텍스트필드 생성
    static func custom(placeholder: String, inputView: UIView? = nil) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.inputView = inputView
        return textField
    }
}

extension UIButton {
    // 제출 버튼 생성
    static func custom(target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}

extension UIDatePicker {
    // date picker 생성
    static func custom(target: Any?, action: Selector) -> UIDatePicker {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.datePickerMode = .date
        datePicker.addTarget(target, action: action, for: .valueChanged)
        return datePicker
    }
}

extension UISegmentedControl {
    static func custom(target: Any?, action: Selector) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: AppConstants.daysOfWeek)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(target, action: action, for: .valueChanged)
        return segmentedControl
    }
}
extension UIBarButtonItem {
    static func custom(title: String, target: Any?, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: title, style: .plain, target: target, action: action)
    }
}
