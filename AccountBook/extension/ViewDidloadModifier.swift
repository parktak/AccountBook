//
//  ViewDidloadModifier.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation
import SwiftUI


extension View {
    func showToastView(_ message: String) -> some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.bottom, 50)
            Spacer()
        }
        .transition(.opacity)
    }
}

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
