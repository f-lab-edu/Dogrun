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
    
    // 파라미터 변환
    func params() -> [String: Any]{
        
        let parameters: [String: Any] = [
            "uid": uid,
            "name": name,
            "birth": birth,
            "area": area,
            "gender": gender
        ]
        
        return parameters
    }
}
