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
    var gender: Gender
    var size: String
    
    // 빌더 구조체
    class Builder {
        
        private var dogInfo = DogInfo(uid: "", name: "", breed: "", birth: "", gender: .etc, size: "")
         
        func uid(_ uid: String) -> Builder {
            dogInfo.uid = uid
            return self
        }
         
        func name(_ name: String) -> Builder {
            dogInfo.name = name
            return self
        }
        
        func breed(_ breed: String) -> Builder {
            dogInfo.breed = breed
            return self
        }
        
        func birth(_ birth: String) -> Builder {
            dogInfo.birth = birth
            return self
        }
        
        func gender(_ gender: Gender) -> Builder {
            dogInfo.gender = gender
            return self
        }
        
        func size(_ size: String) -> Builder {
            dogInfo.size = size
            return self
        }
         
        func build() -> DogInfo {
            return dogInfo
        }
    }
}
