//
//  APIEndpoint.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/14.
//
enum APIEndpointType: String {
    case signIn
    case updateUser
    case updateDog
    case retrieveMainData
}

protocol APIEndpoint {
    var urlString: String { get }
}

struct SignIn: APIEndpoint {
    var urlString: String {
        return "\(EtcKeys.baseUrl.rawValue.localized)/\(APIEndpointType.signIn.rawValue)"
    }
}

struct UpdateUser: APIEndpoint {
    var urlString: String {
        return "\(EtcKeys.baseUrl.rawValue.localized)/\(APIEndpointType.updateUser.rawValue)"
    }
}

struct UpdateDog: APIEndpoint {
    var urlString: String {
        return "\(EtcKeys.baseUrl.rawValue.localized)/\(APIEndpointType.updateDog.rawValue)"
    }
}

struct RetrieveMainData: APIEndpoint {
    var urlString: String {
        return "\(EtcKeys.baseUrl.rawValue.localized)/\(APIEndpointType.retrieveMainData.rawValue)"
    }
}
