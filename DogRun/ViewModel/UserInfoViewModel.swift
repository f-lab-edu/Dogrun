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
   
    
    var persistenceService: ApiService
    
    
    init(persistenceService: ApiService) {
        self.persistenceService = persistenceService
    }

    func update(data: UserInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
      
                let responseData = try await persistenceService.updateUserInfo(data: data)
                // 성공적인 응답 코드를 확인하고 데이터 저장
                if isSuccessResponse(code: responseData.code) {
                    do {
                        try UserDefault().saveUserInfo(data: responseData.data!, keys: "userInfos")
                        completion(true) // 성공적으로 저장되었음을 클로저를 통해 외부에 알림
                    } catch {
                        completion(false) // 데이터 저장 실패를 클로저를 통해 외부에 알림
                        OSLog.message(.error, "data save fail")
                    }
                }
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
 
    
    // 리턴코드 체크
    private func isSuccessResponse(code: Int?) -> Bool {
        guard let valid = code else { return false }
        return valid == ResponseStatus.success.rawValue
    }
    
  
    
}
