//
//  DogInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/26.
//
import Alamofire
import OSLog
import UIKit

final class DogInfoViewModel {
    
    var persistenceService: APIService
    var userDefaultService: DogInfoService
    
    init(persistenceService: APIService, userDefaultService: DogInfoService) {
        self.persistenceService = persistenceService
        self.userDefaultService = userDefaultService
    }
    
    func update(data: DogInfo, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let response = try await persistenceService.updateDogInfo(data: data)
                guard let response else { return completion(false)}
                userDefaultService.save(key: "dogInfos", data: response)
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
    
}
