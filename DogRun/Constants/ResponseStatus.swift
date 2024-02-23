//
//  ResponseStatus.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/15.
//

enum ResponseStatus: Int {
    // response 성공
    case success = 200
    // 이미 회원가입
    case alreadyRegistered = 253
    // 첫 가입
    case firstTimeRegistered = 256
    // 회원 정보 수정
    case editUserInfo = 257
    // 펫 정보 수정
    case editDogInfo = 258
    // 서버 에러
    case unknownError = 500
}
