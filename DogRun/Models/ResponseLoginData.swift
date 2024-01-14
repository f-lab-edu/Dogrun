//
//  ResponseLoginData.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/14.
//

import Foundation

struct ResponseLoginData: Codable {
    
    var code: Int?
    var data: UserInfo?
    var msg: String?
}
