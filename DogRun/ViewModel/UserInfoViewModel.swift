//
//  UserInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//
import Alamofire
import OSLog
import UIKit

final class UserInfoViewModel {
    
    var persistenceService: APIService
    var userDefaultService: UserInfoService
    
    init(persistenceService: APIService, userDefaultService: UserInfoService) {
        self.persistenceService = persistenceService
        self.userDefaultService = userDefaultService
        
    }
    
    func update(data: UserInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.updateUserInfo(data: data)
                guard let response else { return completion(false) }
                userDefaultService.save(key: "userInfos", data: data)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
}
