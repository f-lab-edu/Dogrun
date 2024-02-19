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
        let baseUrl = LocalizationKeys.baseUrl.localized
        let apiUrl = "\(baseUrl)/UserEdit"
        
        let parameters: [String: Any] = [
            "uid": userInfo.userId,
            "name": userInfo.nickName,
            "birth": userInfo.birth,
            "area": userInfo.area,
            "gender": userInfo.selectedGender
        ]

        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    self.responseData = try JSONDecoder().decode(ResponseLoginData.self, from: response.data!)
                    completion(responseData)
                } catch {
                    self.error = error
                    completion(error)
                }

            case .failure(let error):
                self.error = error
                completion(error)
            }
        }
    }
}
