
//  UserInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/05.
//

import UIKit
import Alamofire
import OSLog
import SnapKit


final class UserInfoViewController: UIViewController {
    
    let sidoArea = AppConstants.sidoArea
    let genderArray = AppConstants.genderArray
    let pickerNums = 1
    
    private var captionNickname: UILabel!
    private var captionBirth: UILabel!
    private var captionGender: UILabel!
    private var captionArea: UILabel!
    private var selectArea: String?
    private lazy var selectedGender: String = ""
    
    
    // 닉네임 필드
    private let nicknameTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfNickname.rawValue.localized )
    // 생년월일 필드
    private let birthdateTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfBirth.rawValue.localized, inputView: UIDatePicker())
    // 성별 세그먼트
    private lazy var genderSegmentedControl = UISegmentedControl(items: genderArray)
    // 지역 picker
    private let locationPickerView = UIPickerView()
    // 생년월일 datepicker
    private let datePicker = UIDatePicker.makeCustomDatePicker(target: self, action: #selector(datePickerValueChanged(_:)))
    // 양식 제출 버튼
    private let btnSubmit = UIButton.makeSubmitButton(target: self, action: #selector(update))

    var viewModel: UserInfoViewModel?
    var userInfo: UserInfo?
    
    private let service = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserInfoViewModel(persistenceService: service)
        layout()
    }
    
    // 레이아웃 설정
    private func layout() {
         
        view.backgroundColor = .white
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
      
        initViewName()
        initViewBirth()
        initViewGender()
        initViewArea()
        initViewBtn()
    }
    //
    private func updateUserInfo(data: UserInfo){
        viewModel?.update(data: data) { success in
            if success {
                OSLog.message(.default, "saved successfully")
            } else {
                OSLog.message(.debug, "saved fail")
            }
        }
    }
    
    private func showAlert(message: String) {
        Utils().showAlert(message: message, vc: self)
    }

    private func validateInput() -> (nickname: String?, birth: String?, selectArea: String?) {
        if let nickName = nicknameTextField.text, nickName.isEmpty {
            showAlert(message: LocalizationKeys.alertName.rawValue.localized)
            return (nil, nil, nil)
        }
        if let birth = birthdateTextField.text, birth.isEmpty {
            showAlert(message: LocalizationKeys.alertBirth.rawValue.localized)
            return (nil, nil, nil)
        }
        if selectArea!.isEmpty {
            showAlert(message: LocalizationKeys.alertArea.rawValue.localized)
            return (nil, nil, nil)
        }
        return (nicknameTextField.text, birthdateTextField.text, selectArea)
    }

}
 
// MARK: - picker view 설정
extension UserInfoViewController: UIPickerViewDataSource{
 
    // UIPickerViewDataSource 구현
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerNums
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      // 지역의 수 반환
        return sidoArea.count
    }
}
extension UserInfoViewController: UIPickerViewDelegate {
    // UIPickerViewDelegate 구현
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각 지역의 텍스트 반환
        return sidoArea[row]
    }
}

// MARK: - view click event (objc)
extension UserInfoViewController {
    // 제출버튼 클릭
    @objc func update() {
        // 저장된 로그인 uid
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue) else { return }
        // 닉네임, 성별, 지역 값
        let (nickName, birth, area) = validateInput()
        selectedGender = genderArray[genderSegmentedControl.selectedSegmentIndex]
        userInfo = UserInfo(uid: userId, email: "", name: nickName!, birth: birth!, area: area!, gender: Gender(rawValue: selectedGender)!)
        updateUserInfo(data: userInfo!)
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

// MARK: - layout sub method
extension UserInfoViewController {
    
    func initViewName(){
        // 캡션 (닉네임)
        captionNickname = UILabel.makeCaptionLabel(text: LocalizationKeys.labelName.rawValue.localized)
        view.addSubview(captionNickname)
        captionNickname.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        // 닉네임 입력 필드
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(captionNickname.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    
    func initViewBirth(){
        // 캡션 (생년월일)
        captionBirth = UILabel.makeCaptionLabel(text: LocalizationKeys.labelBirth.rawValue.localized)
        view.addSubview(captionBirth)
        captionBirth.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        // 생년월일 입력 필드
        view.addSubview(birthdateTextField)
        birthdateTextField.snp.makeConstraints {
            $0.top.equalTo(captionBirth.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
        // UITextField에 UIDatePicker 연결
        birthdateTextField.inputView = datePicker
    }
    
    func initViewGender(){
        // 캡션 (성별)
        captionGender = UILabel.makeCaptionLabel(text: LocalizationKeys.labelGender.rawValue.localized)
        view.addSubview(captionGender)
        captionGender.snp.makeConstraints {
            $0.top.equalTo(birthdateTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        // 성별 선택 세그먼트 컨트롤
        view.addSubview(genderSegmentedControl)
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionGender.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    
    func initViewArea(){
        // 캡션 (지역)
        captionArea = UILabel.makeCaptionLabel(text: LocalizationKeys.labelArea.rawValue.localized)
        view.addSubview(captionArea)
        captionArea.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        // 지역 선택 피커 뷰
        locationPickerView.dataSource = self
        locationPickerView.delegate = self
        view.addSubview(locationPickerView)
        locationPickerView.snp.makeConstraints {
            $0.top.equalTo(captionArea.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.pickerViewHeight)
        }
    }
    
    func initViewBtn(){
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.top.equalTo(locationPickerView.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
    }
}


