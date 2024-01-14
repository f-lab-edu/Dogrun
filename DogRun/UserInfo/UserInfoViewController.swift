
//  UserInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/05.
//

import UIKit
import Alamofire

class UserInfoViewController: UIViewController {
    
    let sidoArea = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    private var captionNickname: UILabel!
    private var captionBirth: UILabel!
    private var captionGender: UILabel!
    private var captionArea: UILabel!
    private var selectArea: String?
    private lazy var selectedGender: String = ""
    
    // 항목 라벨
    private func captionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    // 닉네임 필드
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    // 생년월일 필드
    private let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "생년월일을 선택하세요"
        textField.inputView = UIDatePicker()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    // 성별 세그먼트
    private let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["남성", "여성"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    // 지역 picker
    private let locationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    // 생년월일 datepicker
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
    // 양식 제출 버튼
    private let btnSubmit: UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.addTarget(self, action: #selector(submitResult), for: .touchUpInside)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.setTitleColor(.white, for: .normal)
        btnSubmit.backgroundColor = .blue
        return btnSubmit
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        makeView()
    }
    
    private func makeView(){
        // 캡션 (닉네임)
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
        // 캡션 (생년월일)
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
        // 캡션 (성별)
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
        // 캡션 (지역)
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
        // 닉네임, 성별, 지역 값
        guard let nickName = nicknameTextField.text, !nickName.isEmpty else { showAlert(message: "이름을 입력해주세요"); return  }
        guard let birth = birthdateTextField.text,  !birth.isEmpty else {  showAlert(message: "생년월일을 입력해주세요"); return   }
        guard let area = selectArea, !area.isEmpty   else {  showAlert(message: "지역을 선택해주세요"); return   }
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            selectedGender = "남성"
        }else{
            selectedGender = "여성"
        }
        // 저장된 로그인 uid
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        
        let apiUrl = "\(Util.baseUrl)/UserEdit"
        // 전송할 데이터를 담은 파라미터
        let parameters: [String: Any] = [
            "uid": userId,
            "name": nickName,
            "birth": birth,
            "area": area,
            "gender": selectedGender
        ]
        // api 요청
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                   // JSON data decoding (로그인 정보)
                    let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: response.data!)
                   // code optional binding
                    guard let responseCode = responseData.code else { return }
                    if responseCode == 257 {
                        var userInfo = responseData.data
                        do {
                            // UserInfo 인스턴스를 JSON 데이터로 인코딩
                            let encodedData = try JSONEncoder().encode(userInfo)
                            // JSON 데이터를 UserDefaults에 저장
                            UserDefaults.standard.set(encodedData, forKey: "userInfo")
                            // 화면 이동
                            //let homeView = HomeViewController()
                            //self.navigationController?.setViewControllers([homeView], animated: true)
                        } catch {
                            print("Error encoding UserInfo: \(error)")
                        }
                        
                    }else{
                        print("need to check error")
                    }
                } catch {
                   print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
    // 일자 변경시 이벤트 처리
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        print("Selected Date: \(selectedDate)")
        birthdateTextField.text = selectedDate
    }
    // 미기입 시 alert 생성
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
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
