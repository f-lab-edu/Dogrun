//
//  UserInfo.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/07.
//

import Foundation

struct UserInfo: Codable, Identifiable {
    var id = UUID().uuidString
    var uid: String
    var name: String
    var email: String
}
