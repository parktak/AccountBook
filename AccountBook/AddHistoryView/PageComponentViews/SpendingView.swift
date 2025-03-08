//
//  SpendingView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import SwiftUI
//
struct SpendingView: View {
    @ObservedObject var viewModel: AddHistoryViewModelWrapper
    
    
    var body: some View {
        let columns = 4
        let list = viewModel.spendingCategories
        
        if #available(iOS 14.0, *) {
            CategoryVGridView(columns: columns, list: list)
            
        } else {
            CategoryGridListView(columns: columns, list: list)
        }
    }
    
}

//#Preview {
//    SpendingView()
//}
