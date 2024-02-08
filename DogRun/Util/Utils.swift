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
    
    // show toast
    func showToast(_ message : String, withDuration: Double, delay: Double, vc: UIViewController) {
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
