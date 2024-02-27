//  UserInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/05.
//
import Alamofire
import OSLog
import SnapKit
import UIKit

final class UserInfoViewController: UIViewController {
    let pickerNums = 1
    private var captionNickname: UILabel!
    private var captionBirth: UILabel!
    private var captionGender: UILabel!
    private var captionArea: UILabel!
    private var selectArea: String?
    private lazy var selectedGender: String = ""
    // 닉네임 필드
    private let nicknameTextField = UITextField.custom(placeholder: TextFieldKeys.User.name.rawValue.localized )
    // 생년월일 필드
    private let birthdateTextField = UITextField.custom(placeholder: TextFieldKeys.User.birth.rawValue.localized, inputView: UIDatePicker())
    // 성별 세그먼트
    private lazy var genderSegmentedControl = UISegmentedControl(items: AppConstants.genderArray)
    // 지역 picker
    private let locationPickerView = UIPickerView()
    // 생년월일 datepicker
    private let datePicker = UIDatePicker.custom(target: self, action: #selector(datePickerValueChanged(_:)))
    // 양식 제출 버튼
    private let btnSubmit = UIButton.custom(target: self, action: #selector(tapSubmitBtn))
    var viewModel: UserInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        layout()
        initVM()
    }
    private func initView() {
        initTextField()
        initBgColor()
        initCaption()
        initGesture()
        initPicker()
    }
    // 레이아웃 설정
    private func layout() {
        layoutNickName()
        layoutBirth()
        layoutGender()
        layoutArea()
        layoutBtn()
    }
    private func update(data: UserInfo) {
        viewModel?.update(data: data) { success in
            if success {
                OSLog.message(.default, "update done")
            } else {
                OSLog.message(.debug, "update fail")
            }
        }
    }
    private func modifiedInfo() -> UserInfo? {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue) else { return nil }
        guard let nickname = checkNickname(),
              let birthdate = checkBirthdate(),
              let area = checkArea() else { return nil }
        selectedGender = AppConstants.genderArray[genderSegmentedControl.selectedSegmentIndex]
        let userInfo = UserInfo(uid: userId, email: "", name: nickname, birth: birthdate, area: area, gender: Gender(rawValue: selectedGender)!)
        return userInfo
    }
}
// MARK: - picker view 설정
extension UserInfoViewController: UIPickerViewDataSource {
    // UIPickerViewDataSource 구현
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerNums
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 지역의 수 반환
        return AppConstants.sidoArea.count
    }
}
extension UserInfoViewController: UIPickerViewDelegate {
    // UIPickerViewDelegate 구현
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각 지역의 텍스트 반환
        return AppConstants.sidoArea[row]
    }
}
// MARK: - view click event (objc)
extension UserInfoViewController {
    // 제출버튼 클릭
    @objc func tapSubmitBtn() {
        // 저장된 로그인 uid
        guard let userInfo = modifiedInfo() else { return }
        update(data: userInfo)
    }
    // 일자 변경시 이벤트 처리
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yearMonthDay
        let selectedDate = dateFormatter.string(from: datePicker.date)
        birthdateTextField.text = selectedDate
    }
    // UITapGestureRecognizer에 대한 핸들러 메서드
    @objc func handleTap() {
        // picker 창을 내리기 위해 추가
        view.endEditing(true)
    }
}
// MARK: - init
extension UserInfoViewController {
    private func initTextField() {
        // UITextField에 UIDatePicker 연결
        birthdateTextField.inputView = datePicker
    }
    private func initCaption() {
        captionNickname = UILabel.custom(text: LabelKeys.User.name.rawValue.localized) // 닉네임
        captionBirth = UILabel.custom(text: LabelKeys.User.birth.rawValue.localized) // 생년월일
        captionGender = UILabel.custom(text: LabelKeys.User.gender.rawValue.localized) // 성별
        captionArea = UILabel.custom(text: LabelKeys.User.area.rawValue.localized) // 지역
    }
    private func initBgColor() {
        view.backgroundColor = .white
    }
    private func initGesture() {
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    private func initPicker() {
        // 지역 선택 피커 뷰
        locationPickerView.dataSource = self
        locationPickerView.delegate = self
    }
    private func initVM() {
        viewModel = UserInfoViewModel(persistenceService:  APIService())
    }
}

// MARK: - layout sub methods
extension UserInfoViewController {
    private func layoutNickName() {
        constNameLabel()
        constName()
    }
    private func layoutBirth() {
        constBirthLabel()
        constBirth()
    }
    private func layoutGender() {
        constGenderLabel()
        constGender()
    }
    private func layoutArea() {
        constAreaLabel()
        constArea()
    }
    private func layoutBtn() {
        constBtn()
    }
}
// MARK: - const
extension UserInfoViewController {
    private func constNameLabel() {
        view.addSubview(captionNickname)
        captionNickname.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constName() {
        // 닉네임 입력 필드
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(captionNickname.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    private func constBirthLabel() {
        view.addSubview(captionBirth)
        captionBirth.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constBirth() {
        // 생년월일 입력 필드
        view.addSubview(birthdateTextField)
        birthdateTextField.snp.makeConstraints {
            $0.top.equalTo(captionBirth.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    private func constGenderLabel() {
        view.addSubview(captionGender)
        captionGender.snp.makeConstraints {
            $0.top.equalTo(birthdateTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constGender() {
        // 성별 선택 세그먼트 컨트롤
        view.addSubview(genderSegmentedControl)
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionGender.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    private func constAreaLabel() {
        view.addSubview(captionArea)
        captionArea.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constArea() {
        view.addSubview(locationPickerView)
        locationPickerView.snp.makeConstraints {
            $0.top.equalTo(captionArea.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.pickerViewHeight)
        }
    }
    private func constBtn() {
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.top.equalTo(locationPickerView.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
    }
}
// MARK: - input valid check
extension UserInfoViewController {
    private func checkNickname() -> String? {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            showAlert(message: AlertKeys.name.rawValue.localized)
            return nil
        }
        return nickname
    }

    private func checkBirthdate() -> String? {
        guard let birthdate = birthdateTextField.text, !birthdate.isEmpty else {
            showAlert(message: AlertKeys.birth.rawValue.localized)
            return nil
        }
        return birthdate
    }
    private func checkArea() -> String? {
        guard selectArea!.isEmpty else {
            showAlert(message: AlertKeys.area.rawValue.localized)
            return nil
        }
        return selectArea
    }
}
