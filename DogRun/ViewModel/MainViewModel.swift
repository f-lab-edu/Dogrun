//
//  HomeViewModel.swift
//  DogRun
//

import Alamofire
import UIKit
final class MainViewModel {
    
    var persistenceService: APIService
    var userDefaultService: MainInfoService
    
    init(persistenceService: APIService, userDefaultService: MainInfoService) {
        self.persistenceService = persistenceService
        self.userDefaultService = userDefaultService
    }
    
    func retrieve(uid: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.retrieveData(data: uid)
                guard let response else { return completion(false)}
                userDefaultService.save(key: "mainInfo", data: response)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
}
