//
//  ApiService.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/06.
//

import Foundation
import Alamofire

final class APIService {
     
    func updateUserInfo(data: UserInfo) async throws -> UserInfo? {
        do {
            let data = try await URLSession.shared.data(from: URL(string:  APIEndpoint.updateUser.urlString)!).0
            let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: data)
            
            guard Utils().isSuccessResponse(code: responseData.code) else { return nil }
            return responseData.data
        } catch {
            throw error
        }
    }
}
