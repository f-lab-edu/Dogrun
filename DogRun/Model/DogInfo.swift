//
//  DogInfo.swift
//  펫의 정보에 대한 vo
//  DogRun
//


struct DogInfo: Codable {
    
    var uid: String
    var name: String
    var breed: String
    var birth: String
    var gender: String
    var size: String
    
    // 파라미터 변환
    func params() -> [String: Any] {
        return [
            "uid": uid,
            "name": name,
            "birth": birth,
            "breed": breed,
            "gender": gender,
            "size": size
        ]
    }
    
}

