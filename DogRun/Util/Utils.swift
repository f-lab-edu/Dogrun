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
    
    // show toast
    static func showToast(_ message : String, withDuration: Double, delay: Double, vc: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width/2 - 75, y: vc.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
            
        vc.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
