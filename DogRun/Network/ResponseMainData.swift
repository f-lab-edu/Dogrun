//
//  ResponseHomeData.swift
//  DogRun
//
 

import Foundation

struct ResponseMainData: Codable {
    var code: Int? // 리턴 코드
    var data: MainInfo? // 리턴 데이터
    var msg: String? // 리턴 메시지
}
