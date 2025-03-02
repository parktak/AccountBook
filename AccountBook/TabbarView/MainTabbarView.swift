//
//  MainTabbarView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import SwiftUI

struct MainTabbarView: View {
    init() {
        UITabBar.appearance().backgroundColor = .lightGray
    }
    
    var body: some View {
        TabView {
            AccountView().tabItem {
                VStack {
                    Image("icList")
                    Text("기록")
                }
            }
            
            AccountDetailView()
                .tabItem {
                    VStack {
                        Image("icChart")
                        Text("차트")
                    }
                }
            AddHistoryView()
                .tabItem {
                    VStack {
                        Image("icAdd")
                            .resizable()
                            .frame(width: 40,height: 40)
                    }
                }
        }
        
    }
}

//#Preview {
//    MainTabbarView()
//}
