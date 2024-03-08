//
//  LoginViewModel.swift
//  DogRun
//

import Alamofire
import UIKit

final class LoginViewModel {
    
    var persistenceService: APIService
    var userDefaultService: UserInfoService
    
    init(persistenceService: APIService, userDefaultService: UserInfoService) {
        self.persistenceService = persistenceService
        self.userDefaultService = userDefaultService
    }
    
    func signIn(data: LoginInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.signIn(data: data)
                guard let response else { return completion(false)}
                userDefaultService.save(key: "userInfos", data: response)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
}
