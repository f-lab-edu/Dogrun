//
//  UserInfo.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/07.
//

import Foundation

struct UserInfo: Codable {
    var uid: String? // 사용자 uid
    var name: String? // 사용자 닉네임
    var email: String? // 사용자 이메일
}
