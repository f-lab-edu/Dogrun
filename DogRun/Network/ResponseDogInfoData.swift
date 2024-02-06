//
//  ResponseDogInfoData.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/02.
//

import Foundation

struct ResponseDogInfoData: Codable {
    var code: Int? // 리턴 코드
    var data: DogInfo? // 리턴 데이터
    var msg: String? // 리턴 메시지
}
