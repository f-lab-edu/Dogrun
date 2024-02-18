//
//  DogInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/24.
//

import UIKit
import OSLog


final class DogInfoViewController: UIViewController {
    
    let genderArray = AppConstants.genderArray
    let sizeArray = AppConstants.sizeArray
    private lazy var dogGender: String = ""
    private lazy var dogSize: String = ""
    
    var calledFunc = false // test code property
    
    private var captionDogname: UILabel!
    private var captionDogAge: UILabel!
    private var captionDogGender: UILabel!
    private var captionDogBreed: UILabel!
    private var captionDogSize: UILabel!
    
    private let dognameTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfDogName.rawValue.localized )
    private let dogBreedTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfDogBreed.rawValue.localized )
    private let dogAgeTextField = UITextField.makeTextField(placeholder: LocalizationKeys.tfBirth.rawValue.localized )
    
    private lazy var genderSegmentedControl = UISegmentedControl(items: genderArray)
    private lazy var sizeSegmentedControl = UISegmentedControl(items: sizeArray)
    
    var btnSubmit = UIButton.makeSubmitButton(target: self, action: #selector(update))
    
    var viewModel: DogInfoViewModel?
    var dogInfo: DogInfo?
    
    private let service = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DogInfoViewModel(persistenceService: service)
        layout()
    }
    
    private func layout(){
        view.backgroundColor = .white
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        initViewName()
        initViewAge()
        initViewBreed()
        initViewGender()
        initViewSize()
        initViewBtn()
    }
  
 
    private func updateDogInfo(data: DogInfo){
        viewModel?.update(data: data) { success in
            if success {
                OSLog.message(.default, "update done")
            } else {
                OSLog.message(.debug, "update fail")
            }
        }
    }
    
    private func showAlert(message: String) {
        Utils.showAlert(message: message, vc: self)
    }

    private func validateInput() -> (name: String?, birth: String?, breed: String?) {
        if let name = dognameTextField.text, name.isEmpty {
            showAlert(message: LocalizationKeys.tfDogName.rawValue.localized)
            return (nil, nil, nil)
        }
        if let birth = dogAgeTextField.text, birth.isEmpty {
            showAlert(message: LocalizationKeys.alertBirth.rawValue.localized)
            return (nil, nil, nil)
        }
        if let breed = dogBreedTextField.text, breed.isEmpty {
            showAlert(message: LocalizationKeys.tfDogBreed.rawValue.localized)
            return (nil, nil, nil)
        }
        return (dognameTextField.text, dogAgeTextField.text, dogBreedTextField.text)
    }
}

// MARK: - view click event (objc)
extension DogInfoViewController {
    // UITapGestureRecognizer에 대한 핸들러 메서드
    @objc func handleTap() {
        // picker 창을 내리기 위해 추가
        view.endEditing(true)
    }
    
    // 제출버튼 클틱 이벤트
    @objc func update() {
        
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue) else { return }
        let (name, birth, breed) = validateInput()
        dogGender = genderArray[genderSegmentedControl.selectedSegmentIndex]
        dogSize = sizeArray[sizeSegmentedControl.selectedSegmentIndex]
        dogInfo = DogInfo(uid: userId, name: name!, breed: breed!, birth: birth!, gender: dogGender, size: dogSize)
        updateDogInfo(data: dogInfo!)
    }
}

// MARK: - layout sub methods
extension DogInfoViewController{
    
    func initViewName(){
        // 캡션 (펫 이름)
        captionDogname = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogName.rawValue.localized)
        view.addSubview(captionDogname)
        captionDogname.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        
        // 이름 입력 필드
        view.addSubview(dognameTextField)
        dognameTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogname.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    
    func initViewAge(){
        // 캡션 (펫 나이)
        captionDogAge = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogAge.rawValue.localized)
        view.addSubview(captionDogAge)
        captionDogAge.snp.makeConstraints {
            $0.top.equalTo(dognameTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        
        // 나이 입력 필드
        view.addSubview(dogAgeTextField)
        dogAgeTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogAge.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    
    func initViewBreed(){
        // 캡션 (품종)
        captionDogBreed = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogBreed.rawValue.localized)
        view.addSubview(captionDogBreed)
        captionDogBreed.snp.makeConstraints {
            $0.top.equalTo(dogAgeTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        
        // 품종 입력 필드
        view.addSubview(dogBreedTextField)
        dogBreedTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogBreed.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    
    func initViewGender(){
        // 캡션 (성별)
        captionDogGender = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogGender.rawValue.localized)
        view.addSubview(captionDogGender)
        captionDogGender.snp.makeConstraints {
            $0.top.equalTo(dogBreedTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        
        // 성별 선택 세그먼트 컨트롤
        view.addSubview(genderSegmentedControl)
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionDogGender.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    
    func initViewSize(){
        // 캡션 (사이즈)
        captionDogSize = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogSize.rawValue.localized)
        view.addSubview(captionDogSize)
        captionDogSize.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        // 사이즈 선택 세그먼트 컨트롤
        view.addSubview(sizeSegmentedControl)
        sizeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionDogSize.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    
    func initViewBtn(){
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-LayoutConstants.bottomOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
    }
}
