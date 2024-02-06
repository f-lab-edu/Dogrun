//
//  UserInfoConstants.swift
//  DogRun
// 
//

import Foundation

struct AppConstants {
    
    static let sidoArea = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    
    static let genderArray = ["남", "여"]
    
    static let sizeArray = ["S", "M", "L"]
    
    static let dummyUserId = "001598.0282b55949504aebaeec0a9fb2480995.1806"
    
    static let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.userInfo.rawValue)
    
    static let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]

}
