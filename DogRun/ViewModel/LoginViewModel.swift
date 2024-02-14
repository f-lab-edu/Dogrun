//
//  LoginViewModel.swift
//  DogRun
//

import UIKit
import Alamofire

final class LoginViewModel {
    
    var loginInfo: LoginInfo
    var responseData: ResponseLoginData?
    var error: Error?
    
    init(loginInfo: LoginInfo) {
        self.loginInfo = loginInfo
    }

    func submitResult(completion: @escaping (Error?) -> Void) {
        
        let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
        // login url
        let apiUrl = "\(LocalizationKeys.baseUrl.rawValue.localized)/signIn?uid=\(loginInfo.uid)&name=\(loginInfo.name)&email=\(loginInfo.email)"
        
        AF.request(apiUrl).responseJSON { responseData in
            switch responseData.result {
            case .success:
                do {
                    self.responseData = try JSONDecoder().decode(ResponseLoginData.self, from: responseData.data!)
                    self.checkCode()
                     
                } catch {
                    completion(error)
                }

            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // 리턴코드 체크
    private func checkCode(){
        
        guard let responseData = self.responseData else { return }
        guard let code = responseData.code else { return  }
        if code == ResponseStatus.firstTimeRegistered.rawValue || code == ResponseStatus.alreadyRegistered.rawValue { saveData() }
    }
    // 데이터 저장
    private func saveData(){
        do {
            // UserInfo 인스턴스를 JSON 데이터로 인코딩
            let encodedData = try JSONEncoder().encode(responseData?.data)
            // JSON 데이터를 UserDefaults에 저장
            UserDefaults.standard.set(encodedData, forKey: "loginInfos")
            UserDefaults.standard.synchronize()
            
        } catch {
            print("Error encoding UserInfo: \(error)")
        }
    }
    
    // 파라미터 변환
    private func params(data: UserInfo) -> [String: Any]{
        
        let parameters: [String: Any] = [
            "uid": data.uid,
            "name": data.name,
            "birth": data.birth,
            "area": data.area,
            "gender": data.gender
        ]
        
        return parameters
    }
}
