//
//  DogInfoViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/24.
//
import OSLog
import UIKit

final class DogInfoViewController: UIViewController {

    private var captionDogname: UILabel!
    private var captionDogAge: UILabel!
    private var captionDogGender: UILabel!
    private var captionDogBreed: UILabel!
    private var captionDogSize: UILabel!
    private var dognameTextField: UITextField!
    private var dogBreedTextField: UITextField!
    private var dogAgeTextField: UITextField!
    private var genderSegmentedControl: UISegmentedControl!
    private var sizeSegmentedControl: UISegmentedControl!
    private var btnSubmit: UIButton!
    private var viewModel: DogInfoViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        layout()
        initVM()
    }
    private func initView() {
        initTextField()
        initSegCtl()
        initBtn()
        initBgColor()
        initCaption()
        initGesture()
    }

    private func layout() {
        layoutName()
        layoutAge()
        layoutBreed()
        layoutGender()
        layoutSize()
        layoutButton()
    }

    private func update(data: DogInfo) {
        viewModel?.update(data: data) { success in
            if success {
                OSLog.message(.default, "update done")
            } else {
                OSLog.message(.debug, "update fail")
            }
        }
    }
    private func modifiedInfo() -> DogInfo? {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue) else { return nil }
        guard let name = checkName(),
              let birth = checkBirth(),
              let breed = checkBreed() else { return nil }
        let dogGender = AppConstants.genderArray[genderSegmentedControl.selectedSegmentIndex]
        let dogSize = AppConstants.sizeArray[sizeSegmentedControl.selectedSegmentIndex]
        let dogInfo = DogInfo(uid: userId, name: name, breed: breed, birth: birth, gender: .etc, size: dogSize)
        return dogInfo
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
    @objc func tapSubmitBtn() {
        guard let dogInfo = modifiedInfo() else { return }
        update(data: dogInfo)
    }
}
// MARK: - init
extension DogInfoViewController {
    private func initCaption() {
        captionDogname = UILabel.custom(text: LabelKeys.Dog.name.rawValue.localized)
        captionDogAge = UILabel.custom(text: LabelKeys.Dog.age.rawValue.localized)
        captionDogBreed = UILabel.custom(text: LabelKeys.Dog.breed.rawValue.localized)
        captionDogGender = UILabel.custom(text: LabelKeys.Dog.gender.rawValue.localized)
        captionDogSize = UILabel.custom(text: LabelKeys.Dog.size.rawValue.localized)
    }
    private func initBgColor() {
        view.backgroundColor = .white
    }
    private func initGesture() {
        // UITapGestureRecognizer를 사용하여 화면 터치 이벤트를 감지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    private func initTextField() {
        dognameTextField = UITextField.custom(placeholder: TextFieldKeys.Dog.name.rawValue.localized )
        dogBreedTextField = UITextField.custom(placeholder: TextFieldKeys.Dog.breed.rawValue.localized )
        dogAgeTextField = UITextField.custom(placeholder: TextFieldKeys.User.birth.rawValue.localized )
    }
    private func initSegCtl() {
        genderSegmentedControl = UISegmentedControl(items: AppConstants.genderArray)
        sizeSegmentedControl = UISegmentedControl(items: AppConstants.sizeArray)
    }
    private func initBtn() {
        btnSubmit = UIButton.custom(target: self, action: #selector(tapSubmitBtn))
    }
    private func initVM() {
        viewModel = DogInfoViewModel(persistenceService: APIService())
    }
}

// MARK: - const
extension DogInfoViewController {
    private func constNameLabel() {
        // 캡션 (펫 이름)
        view.addSubview(captionDogname)
        captionDogname.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constName() {
        // 이름 입력 필드
        view.addSubview(dognameTextField)
        dognameTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogname.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    private func constAgeLabel() {
        view.addSubview(captionDogAge)
        captionDogAge.snp.makeConstraints {
            $0.top.equalTo(dognameTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constAge() {
        // 나이 입력 필드
        view.addSubview(dogAgeTextField)
        dogAgeTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogAge.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    private func constBreedLabel() {
        // 캡션 (품종)
        view.addSubview(captionDogBreed)
        captionDogBreed.snp.makeConstraints {
            $0.top.equalTo(dogAgeTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constBreed() {
        // 품종 입력 필드
        view.addSubview(dogBreedTextField)
        dogBreedTextField.snp.makeConstraints {
            $0.top.equalTo(captionDogBreed.snp.bottom).offset(LayoutConstants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.textFieldHeight)
        }
    }
    private func constGenderLabel() {
        // 캡션 (성별)
        view.addSubview(captionDogGender)
        captionDogGender.snp.makeConstraints {
            $0.top.equalTo(dogBreedTextField.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constGender() {
        // 성별 선택 세그먼트 컨트롤
        view.addSubview(genderSegmentedControl)
        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionDogGender.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    private func constSizeLabel() {
        view.addSubview(captionDogSize)
        captionDogSize.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
        }
    }
    private func constSize() {
        // 사이즈 선택 세그먼트 컨트롤
        view.addSubview(sizeSegmentedControl)
        sizeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(captionDogSize.snp.bottom).offset(LayoutConstants.topOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingTrailingInset)
            $0.height.equalTo(LayoutConstants.segmentedControlHeight)
        }
    }
    private func constButton() {
        // 제출 버튼
        view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-LayoutConstants.bottomOffset)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstants.buttonInset)
            $0.height.equalTo(LayoutConstants.buttonHeight)
        }
    }

}
// MARK: - layout sub methods
extension DogInfoViewController {
    private func layoutName() {
        constNameLabel()
        constName()
    }
    private func layoutAge() {
        constAgeLabel()
        constAge()
    }
    private func layoutBreed() {
        constBreedLabel()
        constBreed()
    }
    private func layoutGender() {
        constGenderLabel()
        constGender()
    }
    private func layoutSize() {
        constSizeLabel()
        constSize()
    }
    private func layoutButton() {
        constButton()
    }
}
// MARK: - input valid check
extension DogInfoViewController {
    private func checkName() -> String? {
        guard let name = dognameTextField.text, !name.isEmpty else {
            showAlert(message: AlertKeys.name.rawValue.localized)
            return nil
        }
        return name
    }

    private func checkBirth() -> String? {
        guard let birthdate = dogAgeTextField.text, !birthdate.isEmpty else {
            showAlert(message: AlertKeys.birth.rawValue.localized)
            return nil
        }
        return birthdate
    }
    private func checkBreed() -> String? {
        guard let breed = dogBreedTextField.text, !breed.isEmpty else {
            showAlert(message: AlertKeys.birth.rawValue.localized)
            return nil
        }
        return breed
    }
}
