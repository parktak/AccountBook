//
//  AddHistoryView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/23.
//

import SwiftUI

struct AddHistoryView: View {
    @State private var selectedIndex = 0
    
    
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ZStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("취소")
                    })
                    
                    Spacer()
                }
                Text("추가")
                    
            }
            .frame(maxWidth: .infinity)
            
            Picker("type", selection: $selectedIndex) {
                Text("지출").tag(0)
                Text("수입").tag(1)
                Text("이체").tag(2)
            }
            .pickerStyle(.segmented)
            makePageView()
        })
        .frame(maxWidth: .infinity, minHeight: 50, alignment: .top)
        .padding(.horizontal, 16)
        
    }
    
    private func makePageView() -> some View {
        
//        if #available(iOS 14.0, *) {
//            return pageViewFor14()
//        } else {
            return pageViewControllerForUIKit()
//        }
    }
    
    @available(iOS 14.0, *)
    private func pageViewFor14() -> some View {
        TabView(selection: $selectedIndex) {
            SpendingView().tag(0)
            IncomingView().tag(1)
            TransferView().tag(2)
        }
        .tabViewStyle(.page)
    }
    
    private func pageViewControllerForUIKit() -> some View {
        AddHistoryViewPageViewControllerWrapper(page: $selectedIndex)
    }
}


struct SpendingView: View {
    var body: some View {
        Text("a")
    }
}

struct IncomingView: View {
    var body: some View {
        Text("d")
    }
}

struct TransferView: View {
    var body: some View {
        Text("Transfeer")
    }
}

//#Preview {
//    AddHistoryView()
//}
