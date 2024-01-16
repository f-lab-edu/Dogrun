//    ViewController.swift
//
//        스플래시 화면을 지난 후 로그인 화면입니다.
//        로고와 애플로그인 버튼으로 구성되어있습니다.
//        애플로그인 시도 후 서버에 id가 존재하면 홈 화면,
//        없을시 회원정보 입력화면으로 이동됩니다.
//
//    Created by 이규관 on 2024/01/03.

import UIKit
import SnapKit
import AuthenticationServices
import Alamofire
import OSLog

class ViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let welcomeLabel = UILabel()
    let btnLogin = UIButton()
    let btnAppleLogin = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)

    override func viewDidLoad(){
       super.viewDidLoad()
        
       makeView()
       initView()
    }
    
    private func makeView(){
        
        self.view.backgroundColor = .white
        [logoImageView, welcomeLabel, btnAppleLogin].forEach({view.addSubview($0)})

        // 로고 이미지 뷰
        self.logoImageView.snp.makeConstraints({
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.80)
        })
        
        // 서비스 라벨
        self.welcomeLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(20)
        })
        
        // 애플로그인 버튼
        self.btnAppleLogin.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.top.equalTo(self.welcomeLabel.snp.bottom).offset(60)
            $0.height.equalTo(50)
        })
    }
    
    private func initView(){
        
        logoImageView.image = UIImage(named: "logo")
        logoImageView.tintColor = .systemGray
        self.logoImageView.contentMode = .scaleAspectFit
        
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        welcomeLabel.text = "DogRun"
        welcomeLabel.textColor = .label

        btnAppleLogin.layer.cornerRadius = 25
        btnAppleLogin.backgroundColor = .white
        btnAppleLogin.layer.borderWidth = 0.5
        btnAppleLogin.addTarget(self, action: #selector(clickAppleLogin), for: .touchUpInside)
    }
    
    // 데이터 저장
    private func saveData(_ loginData: ResponseLoginData, _ lable: String){
        
        let valueToSave = loginData.data
        UserDefaults.standard.set(valueToSave, forKey: lable)
    }
    
    // 화면 분기처리 이동
    private func moveToNext(_ responseCode: Int){
        
        if let status = ResponseStatus(rawValue: responseCode) {
            
            switch status {
                
                case .alreadyRegistered:
                    // 이미 가입된 계정일 경우 - 홈 이동
                    // 홈화면 이동
                    let homeView = HomeViewController()
                    self.navigationController?.setViewControllers([homeView], animated: true)
                case .firstTimeRegistered:
                    // 첫 가입된 계정일때 - 회원정보 입력
                    let userInfoView = UserInfoViewController()
                    self.navigationController?.setViewControllers([userInfoView], animated: true)
                case .unknownError:
                    os_log("Unknown login error",log:.debug)
                }
        } else {
            os_log("Unknown response status: \(responseCode)",log:.debug)
        }
    }
    
    // 애플로그인 버튼 클릭
    @objc func clickAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // login url
            let baseUrl = String(NSLocalizedString("baseUrl", comment: "api request url"))
            let apiUrl = "\(baseUrl)/signIn?uid=\(userIdentifier)&name=\(fullName)&email=\(email)"
            
            // api 요청
            AF.request(apiUrl).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: response.data!)
                        guard let responseCode = responseData.code else { return }
                        
                        // 데이터 저장
                        saveData(responseData, UserDefaultsKeys.userInfo)
                        
                        // 다음 화면 이동
                        moveToNext(responseCode)
                        
                    } catch {
                        os_log("Error decoding JSON: \(error)",log:.debug)
                    }
                case .failure(let error):
                    os_log("API Error: \(error)",log:.debug)
                }
            }
        }

    }
}
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
