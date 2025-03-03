//
//  FullScreenSheetHelper.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/03.
//

import Foundation
import SwiftUI

struct FullScreenSheetHelper<Content: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    @Binding var isPresented: Bool
    let content: () -> Content
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if !isPresented {
            if let presetnedViewController = uiViewController.presentedViewController {
                presetnedViewController.dismiss(animated: true)
            }
            
            return
        }
        
        let hostingViewController = UIHostingController(rootView: content())
        hostingViewController.modalPresentationStyle = .fullScreen
        uiViewController.present(hostingViewController, animated: true)
    }
}

extension View {
    func fullScreenSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(
            FullScreenSheetHelper(isPresented: isPresented, content: content)
        )
    }
}

