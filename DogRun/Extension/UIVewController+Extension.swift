//
//  UIVewController+Extension.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/21.
//

import UIKit

extension UIViewController {
    func showAlert(message:String) {
        let alert = UIAlertController(title: AlertKeys.alertTitle.rawValue.localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertKeys.alertConfirm.rawValue.localized, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
