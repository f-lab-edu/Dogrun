//
//  UserDefaultsUserRepository.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
//

import Foundation
import OSLog
 
final class UserDefaultsRepository: UserRepository {
    let userDefaults: UserDefaults
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    func setUserInfo(userInfo: UserInfo, keys: String) {
        do {
            let encodedData = try JSONEncoder().encode(userInfo)
            userDefaults.set(encodedData, forKey: keys)
        } catch {
            OSLog.debug("Error encoding user info: \(error)")
        }
    }
    func getUserInfo(keys: String) -> UserInfo? {
        guard let encodedData = userDefaults.data(forKey: keys) else {
            return nil
        }
        do {
            let userInfo = try JSONDecoder().decode(UserInfo.self, from: encodedData)
            return userInfo
        } catch {
            return nil
        }
    }
    func setDogInfo(dogInfo: DogInfo, keys: String) {
        do {
            let encodedData = try JSONEncoder().encode(dogInfo)
            userDefaults.set(encodedData, forKey: keys)
        } catch {
            OSLog.debug("Error encoding user info: \(error)")
        }
    }
    func getDogInfo(keys: String) -> DogInfo? {
        guard let encodedData = userDefaults.data(forKey: keys) else {
            return nil
        }
        do {
            let dogInfo = try JSONDecoder().decode(DogInfo.self, from: encodedData)
            return dogInfo
        } catch {
            return nil
        }
    }
}
