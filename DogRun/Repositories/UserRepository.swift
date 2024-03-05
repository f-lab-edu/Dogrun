//
//  UserRepository.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
// 
protocol UserRepository {
    // 사용자 정보 get,set
    func setUserInfo(userInfo: UserInfo, keys: String)
    func getUserInfo(keys: String) -> UserInfo?
    // 펫 정보 get,set
    func setDogInfo(dogInfo: DogInfo, keys: String)
    func getDogInfo(keys: String) -> DogInfo?
}
