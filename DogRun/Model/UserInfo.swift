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
    var gender: Gender
    
    // 빌더 구조체
    class Builder {
        
        private var userInfo = UserInfo(uid: "", email: "", name: "", birth: "", area: "", gender: .etc)
         
        func uid(_ uid: String) -> Builder {
            userInfo.uid = uid
            return self
        }
        
        func email(_ email: String) -> Builder {
            userInfo.email = email
            return self
        }
        
        func name(_ name: String) -> Builder {
            userInfo.name = name
            return self
        }
        
        func birth(_ birth: String) -> Builder {
            userInfo.birth = birth
            return self
        }
        
        func area(_ area: String) -> Builder {
            userInfo.area = area
            return self
        }
        
        func gender(_ gender: Gender) -> Builder {
            userInfo.gender = gender
            return self
        }
        
        func build() -> UserInfo {
            return userInfo
        }
    }
}

