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
    init(persistenceService: APIService) {
        self.persistenceService = persistenceService
    }
    func update(data: UserInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.updateUserInfo(data: data)
                guard let response else { return completion(false)}
                saveLocal(data: response)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
    // 데이터 저장
    func saveLocal(data: UserInfo) {
        let userRepository = UserDefaultsRepository()
        userRepository.setUserInfo(userInfo: data, keys: "userInfos")
    }
}
