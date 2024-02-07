//
//  ApiService.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/06.
//

import Foundation
import Alamofire

class ApiService {
    
    let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
   
    
    func userInfoEdit(data: UserInfo,completion: @escaping (Result<ResponseLoginData, Error>) -> Void) {
        
        let apiUrl = "\(baseUrl)/UserEdit"
        AF.request(apiUrl, method: .post, parameters: data.params(), encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
