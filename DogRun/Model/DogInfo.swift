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
         
        func setUID(_ uid: String) -> Builder {
            dogInfo.uid = uid
            return self
        }
         
        func setName(_ name: String) -> Builder {
            dogInfo.name = name
            return self
        }
        
        func setBreed(_ breed: String) -> Builder {
            dogInfo.breed = breed
            return self
        }
        
        func setBirth(_ birth: String) -> Builder {
            dogInfo.birth = birth
            return self
        }
        
        func setGender(_ gender: Gender) -> Builder {
            dogInfo.gender = gender
            return self
        }
        
        func setSize(_ size: String) -> Builder {
            dogInfo.size = size
            return self
        }
         
        func build() -> DogInfo {
            return dogInfo
        }
    }
}
