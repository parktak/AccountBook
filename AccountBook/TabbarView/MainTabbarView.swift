//
//  MainTabbarView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import SwiftUI

enum MainTabType {
    case history, chart
}

struct MainTabbarView: View {
    
    @State var selectedTab: MainTabType = .history

    
    var body: some View {
        VStack {
            switch selectedTab {
            case .history:
                AccountView()
            case .chart:
                AccountDetailView()
            }
            
            Spacer()
            MainTabView(selectedTab: $selectedTab)
        }
        
    }
}

struct MainTabView: View {
    @Binding var selectedTab: MainTabType
    @State var isAddviewPresented = false
    
    var body: some View {
        ZStack (alignment: .bottom) {
            HStack(alignment: .bottom) {
                
                Spacer()
                Button {
                    selectedTab = .history
                    
                } label: {
                    createTabItem(.history, isSelected: selectedTab == .history)
                }
                Spacer()
                Button {
                    selectedTab = .chart
                } label: {
                    createTabItem(.chart, isSelected: selectedTab == .chart)
                }
                Spacer()
                
            }
            .frame(height: 40)
            
            Button {
                withAnimation {
                    isAddviewPresented.toggle()
                }
            } label: {
                VStack {
                    Image("icAdd")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40,height: 40)
                        .foregroundColor(.yellow)
                }
                .frame(alignment: .top)
                .offset(y: -20)
            }
            
        }
        .frame(height: 60)
        .background(Color("34a80Color"))
        .fullScreenSheet(isPresented: $isAddviewPresented) {
            AddHistoryView()
                .onDisappear {
                    isAddviewPresented = false
                }
        }
    }
    
    private func createTabItem(_ type: MainTabType, isSelected: Bool) -> some View {
        let imageName: String
        let title: String
        
        switch type {
        case .history:
            imageName = "icList"
            title = "기록"
        case .chart:
            imageName = "icChart"
            title = "차트"
        }
        
        let selectedColor: Color = Color("AccentColor", bundle: nil)
        let color: Color = .black
        
        return VStack {
            Image(imageName)
                .renderingMode(.template)
                .foregroundColor(isSelected ? selectedColor : color)
                .frame(width: 30,height: 30)
            Text(title)
                .foregroundColor(isSelected ? selectedColor : color)
                .font(.system(size: 12))
        }
        .frame(height: 40, alignment: .bottom)
        
    }
}

//#Preview {
//    MainTabbarView()
//}
