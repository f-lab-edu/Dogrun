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

final class LoginViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let welcomeLabel = UILabel()
    let btnLogin = UIButton()
    let btnAppleLogin = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)

    var viewModel: LoginViewModel?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        viewModel = LoginViewModel(loginInfo: LoginInfo(uid: "", name: "", email: ""))
        layout()
        initView()
    }
     
    private func requestApi(_ userId: String,_ nickName: String,_ email: String){

        let loginInfo = LoginInfo(uid: userId, name: nickName, email: email)

        viewModel = LoginViewModel(loginInfo: loginInfo)
        
        viewModel?.submitResult { [weak self] error in
            
            guard let self = self else { return }

              if let error = error {
                  // TODO: - need to error alert
              } else {
                  // 에러가 없을 경우 화면을 이동.
                  guard let code = viewModel?.responseData?.code else { return }
                  moveToNext(code)
              }
        }
    }
     
    // 화면 분기처리 이동
    private func moveToNext(_ responseCode: Int){
        guard let status = ResponseStatus(rawValue: responseCode) else {
            return
        }
        switch status {
            case .alreadyRegistered:
                // 이미 가입된 계정일 경우 - 홈 이동
                // 홈화면 이동
                os_log("Unknown login error", log: .debug)
            case .firstTimeRegistered:
                // 첫 가입된 계정일때 - 회원정보 입력
                let userInfoView = UserInfoViewController()
                self.navigationController?.setViewControllers([userInfoView], animated: true)
            
            case .unknownError:
                os_log("Unknown login error", log: .debug)
            case .editUserInfo:
                os_log("Unknown login error", log: .debug)
            case .editDogInfo:
                os_log("Unknown login error", log: .debug)
            }
    }
  
}

// MARK: - apple login delegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = "\(appleIDCredential.user)"
            let fullName = "\(appleIDCredential.fullName)"
            let email = "\(appleIDCredential.email)"
            
            requestApi(userIdentifier, fullName, email)
         }

    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


// MARK: - click event (objc)
extension LoginViewController {
    
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


// MARK: - view init
extension LoginViewController {
    
    private func layout(){
        
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
        initLogo()
        initWelcomeLabel()
        initBtnAppleLogin()
    }
    
    private func initLogo(){
        logoImageView.image = UIImage(named: "logo")
        logoImageView.tintColor = .systemGray
        self.logoImageView.contentMode = .scaleAspectFit
    }
    
    private func initWelcomeLabel(){
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        welcomeLabel.text = "DogRun"
        welcomeLabel.textColor = .label
    }

    private func initBtnAppleLogin() {
        btnAppleLogin.layer.cornerRadius = 25
        btnAppleLogin.backgroundColor = .white
        btnAppleLogin.layer.borderWidth = 0.5
        btnAppleLogin.addTarget(self, action: #selector(clickAppleLogin), for: .touchUpInside)
    }
}
