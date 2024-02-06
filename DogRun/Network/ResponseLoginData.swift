//
//  ResponseLoginData.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/14.
//

import Foundation

struct ResponseLoginData: Codable {
    var code: Int? // 리턴 코드
    var data: UserInfo? // 리턴 데이터
    var msg: String? // 리턴 메시지
}
