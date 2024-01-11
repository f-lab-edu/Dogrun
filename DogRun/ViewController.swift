//
//  ViewController.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/03.
//

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

    
extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
              
            
            let url = "\(Util.baseUrl)/signIn?uid=\(userIdentifier)&name=\(fullName)&email=\(email)"

            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
           
                switch response.result {
                case .success(let data):
                    print("회원가입 이동 \(data)")
                    // 홈화면 이동
                    let homeView = HomeViewController()
                    self.navigationController?.setViewControllers([homeView], animated: true)
                 
                case .failure(let error):
                    print("로그인 에러")
                }
            }
             
         
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

   

}

