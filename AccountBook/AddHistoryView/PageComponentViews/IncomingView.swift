//
//  IncomingVIew.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import SwiftUI

struct IncomingView: View {
    @ObservedObject var viewModel: AddHistoryViewModelWrapper
    var body: some View {
        List {
            ForEach(Array(viewModel.incomeCategories)) { category in
                Text(category.title)
            }
        }
    }
}

//#Preview {
//    let viewModel = AddHistoryDIContainer.createAddHistoryViewModelWrapper()
//    AddHistoryDIContainer.createIncomingView(viewModel)
//}
