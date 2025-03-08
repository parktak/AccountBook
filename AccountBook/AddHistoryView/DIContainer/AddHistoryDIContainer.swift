//
//  AddHistoryDIContainer.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import Foundation

class AddHistoryDIContainer {
    static func createAddHistoryView() -> AddHistoryView {
        let viewModel = AddHistoryViewModel()
        viewModel.loadData()
        return AddHistoryView(viewModel: viewModel)
    }
   
    static func createAddHistoryViewModelWrapper(viewModel: AddHistoryViewModel, type: AddHistoryType) -> AddHistoryViewModelWrapper {
        return AddHistoryViewModelWrapper(viewModel: viewModel, type: type)
    }
    
    static func createSpendingView(_ viewModel: AddHistoryViewModel) -> MakeHistoryView {
        let wrapper = createAddHistoryViewModelWrapper(viewModel: viewModel, type: .spending )
        return MakeHistoryView(viewModelWrapper: wrapper)
    }
    
    static func createIncomView(_ viewModel: AddHistoryViewModel) -> MakeHistoryView {
        let wrapper = createAddHistoryViewModelWrapper(viewModel: viewModel, type: .income )
        return MakeHistoryView(viewModelWrapper: wrapper)
    }
}
