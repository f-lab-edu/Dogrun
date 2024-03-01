//
//  UserInfo.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//

struct UserInfo: Codable {
    
    var uid: String
    var email: String
    var name: String
    var birth: String
    var area: String
    
    // 빌더 구조체
    struct Builder {
        
        private var userInfo: UserInfo = UserInfo(uid: "", email: "", name: "", birth: "", area: "")
         
        mutating func setUID(_ uid: String) -> Builder {
            userInfo.uid = uid
            return self
        }
        
        mutating func setEmail(_ email: String) -> Builder {
            userInfo.email = email
            return self
        }
        
        mutating func setName(_ name: String) -> Builder {
            userInfo.name = name
            return self
        }
        
        mutating func setBirth(_ birth: String) -> Builder {
            userInfo.birth = birth
            return self
        }
        
        mutating func setArea(_ area: String) -> Builder {
            userInfo.area = area
            return self
        }
        
        func build() -> UserInfo {
            return userInfo
        }
    }
}

