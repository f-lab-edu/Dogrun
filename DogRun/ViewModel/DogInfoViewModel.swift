//
//  DogInfoViewModel.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/26.
//
import UIKit
import Alamofire
import OSLog

final class DogInfoViewModel {
    
    var viewController: UIViewController
    var dogInfo: DogInfo
    var responseData: ResponseDogInfoData?
    var error: Error?
    
    init(viewController: UIViewController, dogInfo: DogInfo) {
        self.viewController = viewController
        self.dogInfo = dogInfo
    }

    func update(completion: @escaping (Error?) -> Void) {
        let baseUrl = LocalizationKeys.baseUrl.rawValue.localized
        let apiUrl = "\(baseUrl)/DogInfoEdit"
          
        AF.request(apiUrl, method: .post, parameters: params(data: dogInfo), encoding: JSONEncoding.default).responseData { responseData in
            switch responseData.result {
            case .success:
               
                do {
                    self.responseData = try JSONDecoder().decode(ResponseDogInfoData.self, from: responseData.value!)
                    self.checkCode()
                } catch {
                    completion(error)
                }

            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // 리턴코드 체크
    private func checkCode(){
        
        guard let responseData = self.responseData else { return }
        guard let code = responseData.code else { return  }
        if code == ResponseStatus.editDogInfo.rawValue  { saveData() }
        
    }
    // 응답데이터 저장
    private func saveData(){
        do {
            // UserInfo 인스턴스를 JSON 데이터로 인코딩
            let encodedData = try JSONEncoder().encode(responseData?.data)
            // JSON 데이터를 UserDefaults에 저장
            UserDefaults.standard.set(encodedData, forKey: "dogInfos")
            UserDefaults.standard.synchronize()
            
        } catch {
            print("Error encoding UserInfo: \(error)")
        }
    }
    
    // 파라미터 변환
    private func params(data: DogInfo) -> [String: Any]{
        
        let parameters: [String: Any] = [
            "uid": AppConstants.dummyUserId,
            "name": data.name,
            "breed": data.breed,
            "birth": data.birth,
            "size": data.size,
            "gender": data.gender
        ]
        
        return parameters
    }
}

