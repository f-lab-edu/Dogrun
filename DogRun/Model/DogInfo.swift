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
    struct Builder {
        
        private var dogInfo: DogInfo = DogInfo(uid: "", name: "", breed: "", birth: "", gender: .etc, size: "")
         
        mutating func setUID(_ uid: String) -> Builder {
            dogInfo.uid = uid
            return self
        }
         
        mutating func setName(_ name: String) -> Builder {
            dogInfo.name = name
            return self
        }
        
        mutating func setBreed(_ breed: String) -> Builder {
            dogInfo.breed = breed
            return self
        }
        
        mutating func setBirth(_ birth: String) -> Builder {
            dogInfo.birth = birth
            return self
        }
        
        mutating func setGender(_ gender: Gender) -> Builder {
            dogInfo.gender = gender
            return self
        }
        
        mutating func setSize(_ size: String) -> Builder {
            dogInfo.size = size
            return self
        }
         
        func build() -> DogInfo {
            return dogInfo
        }
    }
}
