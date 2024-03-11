//
//  MainInfoService.swift
//  DogRun
//
//  Created by 이규관 on 2024/03/08.
//

import Foundation
import OSLog

class MainInfoService: UserDefaultsRepository {
     
    let userDefaults = UserDefaults()
    
    func save(key: String, data: Any) {
        do {
            let mainInfo = data as? MainInfo
            let encodedData = try JSONEncoder().encode(mainInfo)
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
            let mainInfo = try JSONDecoder().decode(MainInfo.self, from: encodedData)
            return mainInfo
        }
    }
}
