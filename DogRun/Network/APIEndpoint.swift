//
//  APIEndpoint.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
//
enum APIEndpoint {
    case signIn
    case updateUser
    case updateDog
    case retrieveMainData

    var urlString: String {
        let baseUrl = EtcKeys.baseUrl.rawValue.localized
        switch self {
        case .updateUser:
            return "\(baseUrl)/updateUser"
        case .updateDog:
            return "\(baseUrl)/updateDog"
        case .retrieveMainData:
            return "\(baseUrl)/retrieveMainData"
        case .signIn:
            return "\(baseUrl)/signIn"
        }
    }
}
