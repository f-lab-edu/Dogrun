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

class ViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let welcomeLabel = UILabel()
    let btnLogin = UIButton()
    let btnAppleLogin = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)

    override func viewDidLoad(){
       super.viewDidLoad()
        
       self.makeView()
       self.initView()
    }
    
    private func makeView(){
        
        self.view.backgroundColor = .white
        [logoImageView, welcomeLabel, btnAppleLogin].forEach({view.addSubview($0)})

        self.logoImageView.snp.makeConstraints({
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.80)
        })

        self.welcomeLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(20)
        })

        self.btnAppleLogin.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.top.equalTo(self.welcomeLabel.snp.bottom).offset(60)
            $0.height.equalTo(50)
        })
    }
    
    private func initView(){
        self.logoImageView.image = UIImage(named: "logo")
        self.logoImageView.tintColor = .systemGray
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.welcomeLabel.numberOfLines = 0
        self.welcomeLabel.textAlignment = .center
        self.welcomeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.welcomeLabel.text = "DogRun"
        self.welcomeLabel.textColor = .label

        self.btnAppleLogin.layer.cornerRadius = 25
        self.btnAppleLogin.backgroundColor = .white
        self.btnAppleLogin.layer.borderWidth = 0.5
        self.btnAppleLogin.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
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
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            // login url
            let apiUrl = "\(Util.baseUrl)/signIn?uid=\(userIdentifier)&name=\(fullName)&email=\(email)"
            // api 요청
            AF.request(apiUrl).responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    do {
                       // JSON data decoding (로그인 정보)
                        let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: response.data!)
                        // userInfo 내부저장소 저장
                        let valueToSave = responseData.data
                        UserDefaults.standard.set(valueToSave, forKey: "userInfo")
                       // code optional binding
                        guard let responseCode = responseData.code else { return }
                        if responseCode == 253 {
                            // 이미 가입된 계정일 경우 - 홈 이동
                            // 홈화면 이동
                            //let homeView = HomeViewController()
                            //self.navigationController?.setViewControllers([homeView], animated: true)
                        }else if responseCode == 256 {
                            // 첫 가입된 계정일때 - 회원정보 입력
                            //let userInfoView = UserInfoViewController()
                            //self.navigationController?.setViewControllers([userInfoView], animated: true)
                        }else{
                            print("login error")
                        }
                    } catch {
                       print("Error decoding JSON: \(error)")
                    }
                case .failure(let error):
                    print("API Error: \(error)")
                }
            }
                default:
                    break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) { 
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

