//
//  ContentView.swift
//  HouseholdAccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AccountBookViewModel()
    
    var body: some View {
        MainTabbarView()
    }
}

//#Preview {
//    ContentView()
//}
