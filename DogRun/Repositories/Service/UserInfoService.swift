//
//  UserInfoService.swift
//  DogRun
//
//  Created by 이규관 on 2024/03/07.
//

import Foundation
import OSLog

class UserInfoService: UserDefaultsRepository {
    
    let userDefaults = UserDefaults()
    
    func save(key: String, data: Any) {
        do {
            let userInfo = data as? UserInfo
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
            let userInfo = try JSONDecoder().decode(UserInfo.self, from: encodedData)
            return userInfo
        }
    }
}
