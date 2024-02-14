//
//  UserRepository.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
// 
protocol UserRepository {
    func setUserInfo(userInfo: UserInfo)
    func getUserInfo() -> UserInfo?
}
