//
//  MainTabbarView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import SwiftUI

struct MainTabbarView: View {
    var body: some View {
        TabView {
            AccountView().tabItem {
                Text("기록")
            }
            AccountDetailView()
                .tabItem {
                    Text("차트")
                }
        }
    }
}

//#Preview {
//    MainTabbarView()
//}
