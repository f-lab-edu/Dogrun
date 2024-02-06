//
//  HomeViewModel.swift
//  DogRun
//


import UIKit
import Alamofire

class MainViewModel {
    
    var uid: String?
    var responseData: ResponseMainData?
    var error: Error?
    
    init(uid: String) {
        self.uid = uid
    }

    func submitResult(completion: @escaping (Error?) -> Void) {
        
        let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
        // login url
        let apiUrl = "\(LocalizationKeys.baseUrl.rawValue.localized)/home?uid=\(uid)"
        
        AF.request(apiUrl).responseJSON { responseData in
            switch responseData.result {
            case .success:
                do {
                    self.responseData = try JSONDecoder().decode(ResponseMainData.self, from: responseData.data!)
                    self.checkCode(completion: completion)
                    completion(nil)
                } catch {
                    completion(error)
                }

            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // 리턴코드 체크
    private func checkCode(completion: @escaping (Error?) -> Void) {
        
        guard let responseData = self.responseData else { return }
        guard let code = responseData.code else { return  }
        if code == ResponseStatus.firstTimeRegistered.rawValue || code == ResponseStatus.mainDataInit.rawValue { completion(nil) }
    }
}

