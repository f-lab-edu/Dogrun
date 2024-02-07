//
//  UserInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//
import UIKit
import Alamofire
import OSLog


class UserInfoViewModel {
   
    
    var apiService: ApiService
    
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }

    func save(data: UserInfo, completion: @escaping (Bool) -> Void) {
        apiService.userInfoEdit(data: data) { result in
            switch result {
            case .success(let responseData):
                
                let success = self.isSuccessResponse(code: responseData.code)
                
                if success {
                    do {
                        try UserDefault().saveUserInfo(data: responseData.data!, keys: "userInfos")
                        completion(true) // 성공적으로 저장되었음을 클로저를 통해 외부에 알림
                    } catch {
                        completion(false) // 데이터 저장 실패를 클로저를 통해 외부에 알림
                        OSLog.message(.error, "data save fail")
                    }
                }
            case .failure(let error):
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
                OSLog.message(.error, "\(error)")
            }
        }
    }
    
    // 리턴코드 체크
    private func isSuccessResponse(code: Int?) -> Bool {
        guard let valid = code else { return false }
        return valid == ResponseStatus.responseSuccess.rawValue
    }
    
}
