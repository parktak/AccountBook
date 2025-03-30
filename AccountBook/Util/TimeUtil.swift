//
//  TimeUitl.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/30.
//

import Foundation

class TimeUtil {
    static func now() -> String {
        return Date().getCurrentTime()
    }
    
    static func today() -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy MM dd"
        
        
        return dateFormmater.string(from: Date())
    }
}
