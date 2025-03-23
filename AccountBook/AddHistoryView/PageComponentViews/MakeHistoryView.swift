//
//  SpendingView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import SwiftUI

struct MakeHistoryView: View {
    @ObservedObject var viewModelWrapper: AddHistoryViewModelWrapper
    
    
    var body: some View {
        let columns = 4
        
        if #available(iOS 14.0, *) {
            CategoryVGridView(columns: columns, viewModelWrapper: viewModelWrapper)
            
        } else {
            CategoryGridListView(columns: columns, viewModelWrapper: viewModelWrapper)
        }
    }
    
}

struct MakeHistoryView_Previews: PreviewProvider {
    
    static var previews: MakeHistoryView {
        let viewModel = AddHistoryViewModel()
        viewModel.loadData()
        return AddHistoryDIContainer.createSpendingView(viewModel)
    }
}
