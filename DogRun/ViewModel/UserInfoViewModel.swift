//
//  UserInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//
import UIKit
import Alamofire

class UserInfoViewModel {
    var userInfo: UserInfo
    var responseData: ResponseLoginData?
    var error: Error?
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }

    func submitResult(completion: @escaping (Error?) -> Void) {
        
        let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
        let apiUrl = "\(baseUrl)/UserEdit"
        
        AF.request(apiUrl, method: .post, parameters: params(data: userInfo), encoding: JSONEncoding.default).responseData { responseData in
            switch responseData.result {
            case .success:
                do {
                    self.responseData = try JSONDecoder().decode(ResponseLoginData.self, from: responseData.value!)
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
        if code == ResponseStatus.editUserInfo.rawValue { saveData() }
    }
    // 데이터 저장
    private func saveData(){
        do {
            // UserInfo 인스턴스를 JSON 데이터로 인코딩
            let encodedData = try JSONEncoder().encode(responseData?.data)
            // JSON 데이터를 UserDefaults에 저장
            UserDefaults.standard.set(encodedData, forKey: "userInfos")
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
