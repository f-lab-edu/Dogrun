//
//  UserDefaultsUserRepository.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
//

import Foundation
import OSLog

class UserDefaultsUserRepository: UserRepository {
    
    let userDefaults: UserDefaults
    let userInfoKey = "userInfo"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func setUserInfo(userInfo: UserInfo) {
        do {
            let encodedData = try JSONEncoder().encode(userInfo)
            userDefaults.set(encodedData, forKey: userInfoKey)
        } catch {
            OSLog.message(.debug, "Error encoding user info: \(error)")
        }
    }
    
    func getUserInfo() -> UserInfo? {
        guard let encodedData = userDefaults.data(forKey: userInfoKey) else {
            return nil
        }
        do {
            let userInfo = try JSONDecoder().decode(UserInfo.self, from: encodedData)
            return userInfo
        } catch {
            return nil
        }
    }
}
