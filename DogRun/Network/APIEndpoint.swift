//
//  APIEndpoint.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
//


enum APIEndpoint {
    
    case createUser
    case updateUser
    case updateDog
    case retrieveMainData

    var urlString: String {
        let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
        
        switch self {
        case .createUser:
           return "\(baseUrl)/createUser"
        case .updateUser:
           return "\(baseUrl)/updateUser"
        case .updateDog:
           return "\(baseUrl)/updateDog"
        case .retrieveMainData:
           return "\(baseUrl)/retrieveMainData"
        }
    }
}
