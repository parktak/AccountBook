//
//  Extensions.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/02.
//

import Foundation
import OSLog

enum LogLevel {
    case debug, info, warning, error, fatal
}

struct Logger {
    private static let log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "AccountBook", category: "parktak")
    
    static func writeLog(message: String, level: LogLevel = .debug, isNeededStackTraceInfo : Bool = true, line : Int = #line, fileName : String = #file) {
        let logType: OSLogType
        
        var emoji = ""
        switch level {
        case .debug :
            logType = .debug
            emoji = "ℹ️"
        case .info:
            logType = .info
            emoji = "✅"
        case .warning:
            logType = .default
            emoji = "⚠️"
        case .error:
            logType = .error
            emoji = "❌"
        case .fatal:
            logType = .fault
            emoji = "🚫"
        }
        
        var logMessage = "[\(Date().getCurrentTime())] : \(emoji) : \(message) -> \(fileName.split(separator: "/").last!) :\(line)\r\n"
        
        if isNeededStackTraceInfo {
            logMessage += Thread.callStackSymbols.joined(separator: "\r\n")
        }
        
#if DEBUG
        if level == .error || level == .fatal {
            saveLog(logMessage)
        }
#endif
        os_log("%@", log: log, type: logType, logMessage)
    }
    
    private static func saveLog(_ message: String) {
        DispatchQueue.global().async {
            
            guard let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }
            
            let currentTime = Date().getCurrentTime()
            let fileName = "errorLog_\(currentTime)"
            let fileUrl = documentDir.appendingPathComponent(fileName)
            
            do {
                if !FileManager.default.fileExists(atPath: fileUrl.path) {
                    try message.write(to: fileUrl, atomically: false, encoding: .utf8)
                    return
                }
                
                let fileHandle = try FileHandle(forWritingTo: fileUrl)
                if #available(iOS 13.4, *) {
                    try fileHandle.seekToEnd()
                } else {
                    fileHandle.seekToEndOfFile()
                }
                
                guard let data = message.data(using: .utf8) else {
                    return
                }
                if #available(iOS 13.4, *) {
                    try fileHandle.write(contentsOf: data)
                } else {
                    fileHandle.write(data)
                }
                 
                try fileHandle.close()
                
            } catch {
                fatalError("로그 파일 열기 또는 추가 실패 \(error.localizedDescription)")
            }
        }
    }
}

extension Date {
    func getCurrentTime(_ format: String = "yyyy mm dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
