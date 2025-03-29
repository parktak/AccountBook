//
//  NsRegularExpressionExtension.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/29.
//

import Foundation

extension NSRegularExpression {
    func split(string: String) -> [String] {
        let matches = self.matches(in: string, range: NSRange(string.startIndex..., in: string))
        
        var lastIndex = string.startIndex
        var result: [String] = []
        for match in matches {
            guard let range = Range(match.range, in: string) else {
                continue
            }
            
            if lastIndex < range.lowerBound {
                result.append( String(string[lastIndex ..< range.lowerBound]))
            }
            
            result.append(String(string[range]))
            lastIndex = range.upperBound
        }
        
        if lastIndex < string.endIndex {
            result.append(String(string[lastIndex ..< string.endIndex]))
        }
        return result
    }
}
