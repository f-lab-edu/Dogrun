//
//  Utils.swift
//  DogRun
//
//

import UIKit

class Utils {
    
    // 미기입 시 alert 생성
    func showAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: LocalizationKeys.alertTitle.rawValue.localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationKeys.alertConfirm.rawValue.localized, style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
        // 경고창 표시 후 메소드 종료
        return
    }
    
}
