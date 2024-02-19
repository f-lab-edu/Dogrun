//
//  OSLog+Extension.swift
//  DogRun
//
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
