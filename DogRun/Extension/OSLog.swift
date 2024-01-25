//
//  OSLog.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/15.
//

import Foundation
import os.log

extension OSLog {
    
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
    
    static func message(_ type: OSLogType, log: OSLog = .default, _ message: String) {
        os_log(type, log: log, "%@", message)
    }
}
