//
//  UserDefaults.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/07.
//

import UIKit

final class UserDefault {
    
    // 데이터 저장
    func saveUserInfo(data: UserInfo, keys: String) throws{
        do {
            // UserInfo 인스턴스를 JSON 데이터로 인코딩
            let encodedData = try JSONEncoder().encode(data)
            // JSON 데이터를 UserDefaults에 저장
            UserDefaults.standard.set(encodedData, forKey: keys)
            UserDefaults.standard.synchronize()
             
        } catch {
            // JSON 인코딩 에러 처리
            throw error
        }
    }
}
