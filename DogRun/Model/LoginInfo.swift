//
//  LoginInfo.swift
//  DogRun
// 
//

struct LoginInfo: Codable {
    
    var uid: String
    var name: String
    var email: String
    
    // 파라미터 변환
    func params() -> [String: Any] {
        return [
            "uid": uid,
            "name": name,
            "email":email
        ]
    }
}
