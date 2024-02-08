//
//  ApiService.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/06.
//

import Foundation
import Alamofire

final class ApiService {
    
    let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
   
    func updateUserInfo(data: UserInfo) async throws -> ResponseLoginData {
        
        let apiUrl = "\(baseUrl)/UserEdit"
        
        do {
            
            let data = try await URLSession.shared.data(from: URL(string: apiUrl)!).0
            let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: data)
            return responseData
            
        } catch {
            throw error
        }
    }

}
