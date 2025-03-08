//
//  AddHistoryDIContainer.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import Foundation

class AddHistoryDIContainer {
    static func createAddHistoryView() -> AddHistoryView {
        let viewModelWrapper = createAddHistoryViewModelWrapper()
        return AddHistoryView(viewModel: viewModelWrapper)
    }
   
    static func createAddHistoryViewModelWrapper() -> AddHistoryViewModelWrapper {
        let viewModel = AddHistoryViewModel()
        return AddHistoryViewModelWrapper(viewModel: viewModel)
    }
    
    static func createSpendingView(_ viewModel: AddHistoryViewModelWrapper) -> SpendingView {
        SpendingView(viewModel: viewModel)
    }
    
    static func createIncomingView(_ viewModel: AddHistoryViewModelWrapper) -> IncomingView {
        IncomingView(viewModel: viewModel)
    }
}
