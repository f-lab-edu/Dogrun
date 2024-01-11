//
//  UserInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/05.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let sidoArea = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
 
    
    private func captionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "생년월일을 선택하세요"
        textField.inputView = UIDatePicker()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["남성", "여성"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let locationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    
    private let btnSubmit: UIButton = {
        
        let btnSubmit = UIButton()
        btnSubmit.addTarget(self, action: #selector(submitResult), for: .touchUpInside)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.setTitleColor(.white, for: .normal)
        btnSubmit.backgroundColor = .blue
        return btnSubmit
    }()
    
    
    private var captionNickname: UILabel!
    private var captionBirth: UILabel!
    private var captionGender: UILabel!
    private var captionArea: UILabel!
    
    private var selectArea: String?
    private lazy var selectedGender: String = ""
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makeView()
        
    }
    
    
    
    private func makeView(){
        
        captionNickname = captionLabel(text: "닉네임")
        view.addSubview(captionNickname)
        captionNickname.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        
        // 닉네임 입력 필드
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
          $0.top.equalTo(captionNickname.snp.bottom).offset(8)
          $0.leading.trailing.equalToSuperview().inset(20)
          $0.height.equalTo(40)
        }
        
        captionBirth = captionLabel(text: "생년월일")
        view.addSubview(captionBirth)
        captionBirth.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        // 생년월일 입력 필드
        view.addSubview(birthdateTextField)
        birthdateTextField.snp.makeConstraints {
            $0.top.equalTo(captionBirth.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            
        }
        
        captionGender = captionLabel(text: "성별")
        view.addSubview(captionGender)
        captionGender.snp.makeConstraints {
            $0.top.equalTo(birthdateTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        // 성별 선택 세그먼트 컨트롤
        view.addSubview(genderSegmentedControl)
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionGender.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        
        captionArea = captionLabel(text: "지역")
        view.addSubview(captionArea)
        captionArea.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        

        // 지역 선택 피커 뷰
        locationPickerView.dataSource = self
        locationPickerView.delegate = self
        view.addSubview(locationPickerView)
        locationPickerView.snp.makeConstraints {
            $0.top.equalTo(captionArea.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        
        
        
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.top.equalTo(locationPickerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
 
        // UITextField에 UIDatePicker 연결
        birthdateTextField.inputView = datePicker
         

    }
    
    @objc func submitResult() {
        
        var results: [String: Any] = [:]
        
        guard let nickName = nicknameTextField.text, !nickName.isEmpty else { showAlert(message: "이름을 입력해주세요"); return  }
        guard let birth = birthdateTextField.text,  !birth.isEmpty else {  showAlert(message: "생년월일을 입력해주세요"); return   }
        guard let area = selectArea, !area.isEmpty   else {  showAlert(message: "지역을 선택해주세요"); return   }
        
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            selectedGender = "남성"
        }else{
            selectedGender = "여성"
        }
    }
    
     
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        print("Selected Date: \(selectedDate)")
        birthdateTextField.text = selectedDate

      }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        // 경고창 표시 후 메소드 종료
        return
    }
    
    
    
   
    
}


extension UserInfoViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
     
    
    
    // UIPickerViewDataSource 구현
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      // 지역의 수 반환
        return sidoArea.count
    }

      // UIPickerViewDelegate 구현
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      // 각 지역의 텍스트 반환
         
        selectArea = sidoArea[row]
        
        return selectArea
    }
}
