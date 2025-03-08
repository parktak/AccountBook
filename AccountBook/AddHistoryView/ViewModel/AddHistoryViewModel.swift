//
//  AddHistoryViewModel.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import Foundation
import Combine
enum AddHistoryType {
    case spending, income
}

class AddHistoryViewModelWrapper: ObservableObject {
    private(set) var viewModel: AddHistoryViewModel
    @Published var categories = [Category]()
    private var cancellable = Set<AnyCancellable>()
    private var type: AddHistoryType
    
    init(viewModel: AddHistoryViewModel, type: AddHistoryType) {
        self.viewModel = viewModel
        self.type = type
        binding()
    }
    
    private func binding() {
        switch type {
        case .income:
            viewModel.$incomeCategories
                .sink { [weak self] category in
                    self?.categories = category
                }
                .store(in: &cancellable)
        case .spending:
            viewModel.$spendingCategories
                .sink { [weak self] category in
                    self?.categories = category
                }
                .store(in: &cancellable)
        }
    }
    
}

class AddHistoryViewModel {
    
    @Published private(set) var incomeCategories = [Category]()
    @Published private(set) var spendingCategories = [Category]()
    
    func loadData() {
        let categories = MockData.getCategories()
        incomeCategories = categories.filter { $0.type == .income }
        spendingCategories = categories.filter { $0.type == .spending}
        
    }
    
}
