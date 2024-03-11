//
//  DogInfoService.swift
//  DogRun
//
//  Created by 이규관 on 2024/03/08.
//

import Foundation
import OSLog

class DogInfoService: UserDefaultsRepository {
    
    let userDefaults = UserDefaults()
    
    func save(key: String, data: Any) {
        do {
            let userInfo = data as? DogInfo
            let encodedData = try JSONEncoder().encode(userInfo)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            OSLog.debug("Error encoding user info: \(error)")
        }
    }
    
    func retrieval(key: String) throws -> Any? {
        guard let encodedData = userDefaults.data(forKey: key) else {
            return nil
        }
        do {
            let dogInfo = try JSONDecoder().decode(DogInfo.self, from: encodedData)
            return dogInfo
        }
    }
}
