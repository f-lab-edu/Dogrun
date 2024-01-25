//
//  DogInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/26.
//
import UIKit
import Alamofire
import OSLog

class DogInfoViewModel {
    var viewController: UIViewController
    var dogInfo: DogInfo
    var responseData: ResponseDogInfoData?
    var error: Error?
    
    init(viewController: UIViewController, dogInfo: DogInfo) {
        self.viewController = viewController
        self.dogInfo = dogInfo
    }

    func submitResult(completion: @escaping (Error?) -> Void) {
        let baseUrl = LocalizationKeys.baseUrl.localized
        let apiUrl = "\(baseUrl)/DogInfoEdit"
        
        let parameters: [String: Any] = [
            "uid": "test-uid",
            "name": dogInfo.dogName,
            "breed": dogInfo.dogBreed,
            "birth": dogInfo.dogBirth,
            "size": dogInfo.dogSize,
            "gender": dogInfo.dogGender
        ]

        
        let request = AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request.responseData { responseData in
            
            OSLog.message(.debug, "=========== check response : \(responseData)")
            
            switch responseData.result {
            case .success:
               
                do {
                    self.responseData = try JSONDecoder().decode(ResponseDogInfoData.self, from: responseData.value!)
                     
                    self.moveToNext()
                } catch {
                    self.error = error
                    completion(error)
                }

            case .failure(let error):
               
                self.error = error
                completion(error)
            }
        }
    }
    
    // 화면 이동
    private func moveToNext(){
        
        guard let responseData = self.responseData else { return }
        guard let code = responseData.code else { return  }
        
        if code == ResponseStatus.editDogInfo.rawValue {
             
            var dogInfo = responseData.data
            
            do {
                // UserInfo 인스턴스를 JSON 데이터로 인코딩
                let encodedData = try JSONEncoder().encode(dogInfo)
                // JSON 데이터를 UserDefaults에 저장
                UserDefaults.standard.set(encodedData, forKey: "dogInfos")
                UserDefaults.standard.synchronize()
                
            } catch {
                print("Error encoding UserInfo: \(error)")
            }
            
        } else {
            print("need to check error")
        }
    }
}

