
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
    
    let sidoArea = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    let genderArray = ["남성", "여성"]
    let yearMonthDayFormat = "yyyy-MM-dd"
    
    private var captionNickname: UILabel!
    private var captionBirth: UILabel!
    private var captionGender: UILabel!
    private var captionArea: UILabel!
    private var selectArea: String?
    private lazy var selectedGender: String = ""
    
    
    // 닉네임 필드
    private let nicknameTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfNickname.localized   )

    // 생년월일 필드
    private let birthdateTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfBirth.localized ), inputView: UIDatePicker())

    // 성별 세그먼트
    private let genderSegmentedControl = UISegmentedControl(items: genderArray)
    
    // 지역 picker
    private let locationPickerView = UIPickerView()
    
    // 생년월일 datepicker
    private let datePicker = UIDatePicker.makeCustomDatePicker(target: self, action: #selector(datePickerValueChanged(_:)))
    
    // 양식 제출 버튼
    private let btnSubmit = UIButton.makeSubmitButton(target: self, action: #selector(submitResult), title: LocalizationKeys.btnConfirm.localized)
    
    var viewModel: UserInfoViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        makeView()
    }
    
    private func makeView() {
        
        
        
        // 캡션 (닉네임)
        captionNickname = UILabel.makeCaptionLabel(text: LocalizationKeys.labelName.localized))
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
        
        // 캡션 (생년월일)
        captionBirth = UILabel.makeCaptionLabel(text: LocalizationKeys.labelBirth.localized)
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
        
        // 캡션 (성별)
        captionGender = UILabel.makeCaptionLabel(text: LocalizationKeys.labelGender.localized)
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
        
        // 캡션 (지역)
        captionArea = UILabel.makeCaptionLabel(text: LocalizationKeys.labelArea.localized)
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
        
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.top.equalTo(locationPickerView.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
        
        // UITextField에 UIDatePicker 연결
        birthdateTextField.inputView = datePicker
    }
    
    @objc func submitResult() {
        // 저장된 로그인 uid
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo) else { return }
        
        // 닉네임, 성별, 지역 값
        guard let nickName = nicknameTextField.text, !nickName.isEmpty else { showAlert(message: LocalizationKeys.alertName.localized); return  }
        guard let birth = birthdateTextField.text,  !birth.isEmpty else {  showAlert(message: LocalizationKeys.alertBirth.localized); return   }
        guard let area = selectArea, !area.isEmpty   else {  showAlert(message: LocalizationKeys.alertArea.localized); return }
         
        selectedGender = genderArray[genderSegmentedControl.selectedSegmentIndex]
        
        requestApi(userId, nickName, birth, area)
    }
    
    // 일자 변경시 이벤트 처리
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = yearMonthDayFormat
        let selectedDate = dateFormatter.string(from: datePicker.date)
        birthdateTextField.text = selectedDate
    }
    
    // 미기입 시 alert 생성
    private func showAlert(message: String) {
        let alert = UIAlertController(title: LocalizationKeys.alertTitle.localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationKeys.alertConfirm.localized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        // 경고창 표시 후 메소드 종료
        return
    }
    
    // UITapGestureRecognizer에 대한 핸들러 메서드
    @objc func handleTap() {
        // picker 창을 내리기 위해 추가
        view.endEditing(true)
    }
    
    private func requestApi(_ userId: String,_ nickName: String,_ birth: String,_ area: String,){

        let userEditInfo = UserInfo(userId: userId, nickName: nickName, birth: birth, area: area, selectedGender: self.selectedGender)

        viewModel = UserInfoViewModel(userInfo: userEditInfo)
        
        viewModel.submitResult { [weak self] error in
             
            if let error = error {
                print("API Error: \(error)")
            } else {
                self.editCheck()
            }
        }
    }
    
    // 화면 이동
    private func editCheck(_ responseCode: Int){
        
        guard let responseData = viewModel.responseData else { return }

        if responseData.code == ResponseStatus.editUserInfo.rawValue {
            
            var userInfo = responseData.data
            
            do {
                // UserInfo 인스턴스를 JSON 데이터로 인코딩
                let encodedData = try JSONEncoder().encode(userInfo)
                // JSON 데이터를 UserDefaults에 저장
                UserDefaults.standard.set(encodedData, forKey: "userInfo")
            } catch {
                print("Error encoding UserInfo: \(error)")
            }
            
        } else {
            print("need to check error")
        }
    }
}
extension UserInfoViewController: UIPickerViewDataSource{
    // UIPickerViewDataSource 구현
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
        selectArea = sidoArea[row]
        return selectArea
    }
}
