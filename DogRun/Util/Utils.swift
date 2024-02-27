//
//  Utils.swift
//  DogRun
//
//

import UIKit

struct Utils {
    
    // 미기입 시 alert 생성
    static func showAlert(message: String, view: UIViewController) {
        let alert = UIAlertController(title: AlertKeys.title.rawValue.localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertKeys.confirm.rawValue.localized, style: .default, handler: nil)
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    // 응답 코드 확인
    static func isSuccessResponse(code: Int?) -> Bool {
        guard let valid = code else { return false }
        return valid == ResponseStatus.success.rawValue
    }
    
    // JSON 파일에서 데이터를 읽어오는 함수
    static func loadMockDataFromJSONFile(fileName: String) -> Data? {
        // 번들에 있는 JSON 파일 경로 가져오기
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else { return nil }
        do {
            let data = FileManager.default.contents(atPath: path)
            return data
        }
    }
}
