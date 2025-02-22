//
//  ViewExtension.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation
import SwiftUI


extension View {
    func removeSeparator() -> some View {
        if #available(iOS 15.0, *) {
            return self.listRowSeparator(.hidden)
        } else {
            return self.listRowInsets(EdgeInsets())
        }
    }
}
