//
//  UserInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//
import UIKit
import Alamofire
import OSLog


final class UserInfoViewModel {
   
    
    var persistenceService: APIService
    
    
    init(persistenceService: APIService) {
        self.persistenceService = persistenceService
    }

    func update(data: UserInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do { 
                let response = try await persistenceService.updateUserInfo(data: data)
                guard let response else { return completion(false)}
                
                // 데이터 저장
                let userRepository: UserRepository = UserDefaultsUserRepository()
                userRepository.setUserInfo(userInfo: data)
                completion(true)
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
