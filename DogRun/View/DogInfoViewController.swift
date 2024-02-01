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
    
    var btnSubmit = UIButton.makeSubmitButton(target: self, action: #selector(submitResult))
    
    var viewModel: DogInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        layout()
    }
    
    private func layout(){
        
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
        
        
        // 캡션 (사이즈)
        captionDogSize = UILabel.makeCaptionLabel(text: LocalizationKeys.labelDogSize.rawValue.localized)
        view.addSubview(captionDogSize)
        captionDogSize.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
        
        // 성별 선택 세그먼트 컨트롤
        view.addSubview(sizeSegmentedControl)
        sizeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionDogSize.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
        
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-LayoutConstants.bottomOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
    }
  
    
    func requestViewModel(_ userId: String,_ name: String,_ birth: String,_ breed: String,_ size: String,_ gender: String){
        
        var editDogInfo = DogInfo(uid: userId, name: name, breed: breed, birth: birth, gender: gender, size: size)
        
        viewModel = DogInfoViewModel(viewController: self, dogInfo: editDogInfo)
        
        viewModel?.submitResult { [weak self] error in
            guard let error = error else {
                // TODO : 화면 이동 
                return
            }
        }
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
    @objc func submitResult() {
        
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue) else { return }
        // 펫이름, 성별, 나이, 견종, 사이즈
        guard let dogName = dognameTextField.text, !dogName.isEmpty else { Utils().showAlert(message: LocalizationKeys.alertName.rawValue.localized, vc: self); return  }
        guard let dogBirth = dogAgeTextField.text,  !dogBirth.isEmpty else { Utils().showAlert(message: LocalizationKeys.alertBirth.rawValue.localized, vc: self); return   }
        guard let dogBreed = dogBreedTextField.text, !dogBreed.isEmpty else { Utils().showAlert(message: LocalizationKeys.alertArea.rawValue.localized, vc: self); return }
        
        dogGender = genderArray[genderSegmentedControl.selectedSegmentIndex]
        dogSize = sizeArray[sizeSegmentedControl.selectedSegmentIndex]
        
        requestViewModel(userId,dogName,dogBirth,dogBreed,dogGender,dogSize)
    }
}
