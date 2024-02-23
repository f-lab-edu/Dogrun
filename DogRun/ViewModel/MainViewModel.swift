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
                completion(true)
            } catch {
                completion(false) // 네트워크 요청 실패를 클로저를 통해 외부에 알림
            }
        }
    }
}
