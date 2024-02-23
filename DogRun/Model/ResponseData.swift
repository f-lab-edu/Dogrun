//
//  ResponseData.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/18.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
    var code: Int? // 리턴 코드
    var data: T? // 리턴 데이터
    var msg: String? // 리턴 메시지
}
