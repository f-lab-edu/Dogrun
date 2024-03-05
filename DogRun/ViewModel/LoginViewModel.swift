//
//  LoginViewModel.swift
//  DogRun
//

import Alamofire
import UIKit

final class LoginViewModel {
    var persistenceService: APIService
    init(persistenceService: APIService) {
        self.persistenceService = persistenceService
    }
    func signIn(data: LoginInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.signIn(data: data)
                guard let response else { return completion(false)}
                saveLocal(data: response)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
    // 데이터 저장
    private func saveLocal(data: UserInfo) {
        let userRepository = UserDefaultsRepository()
        userRepository.setUserInfo(userInfo: data, keys: "userInfos")
    }
}
