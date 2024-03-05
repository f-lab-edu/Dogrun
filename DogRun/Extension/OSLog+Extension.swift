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
    
    static func debug(log: OSLog = .default, _ message: String) {
        os_log(.debug, log: log, "%@", message)
    }

    static func info(log: OSLog = .default, _ message: String) {
        os_log(.info, log: log, "%@", message)
    }
    
    static func error(log: OSLog = .default, _ message: String) {
        os_log(.error, log: log, "%@", message)
    }
     
    static func message(_ type: OSLogType, log: OSLog = .default, _ message: String) {
        os_log(type, log: log, "%@", message)
    }
}
