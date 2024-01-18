//
//  String+Extension.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/18.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
