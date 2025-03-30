//
//  KeyboardAdaptive.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/30.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    
    @State private var keyboardHeight: CGFloat = 0
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { notification in
            let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            
            return rect?.height
        }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0) }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(
                Publishers.Merge(keyboardWillShow, keyboardWillHide)) { height in
                    withAnimation {
                        self.keyboardHeight = height
                    }
                }
        
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
