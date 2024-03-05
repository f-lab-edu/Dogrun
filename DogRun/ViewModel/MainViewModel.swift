//
//  HomeViewModel.swift
//  DogRun
//

import Alamofire
import UIKit
final class MainViewModel {
    var persistenceService: APIService
    init(persistenceService: APIService) {
        self.persistenceService = persistenceService
    }
    func retrieve(uid: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.retrieveData(data: uid)
                guard let response else { return completion(false)}
                saveLocal(dogData: response.dogData, userData: response.userData)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
    
    // 데이터 저장
    private func saveLocal(dogData: DogInfo,userData: UserInfo) {
        let repository = UserDefaultsRepository()
        repository.setDogInfo(dogInfo: dogData, keys: "dogInfos")
        repository.setUserInfo(userInfo: userData, keys: "userInfos")
    }
}
