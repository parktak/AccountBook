//
//  SpendingView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import SwiftUI

struct SpendingView: View {
    @ObservedObject var viewModel: AddHistoryViewModelWrapper
    var body: some View {
        List {
            ForEach(Array(viewModel.spendingCategories)) { category in
                Text(category.title)
            }
        }
    }
}

//#Preview {
//    SpendingView()
//}
