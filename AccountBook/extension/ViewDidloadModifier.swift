//
//  ViewDidloadModifier.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation
import SwiftUI

typealias ViewDidloadAction = (() -> Void)

struct ViewDidLoadModifier: ViewModifier {
    
    @State private var didLoad = false
    private let action: ViewDidloadAction?
    
    init(perform action: ViewDidloadAction?) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !didLoad {
                didLoad.toggle()
                action?()
            }
        }
    }
    
}

extension View {
    func viewDidload(perfrom action: ViewDidloadAction? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
