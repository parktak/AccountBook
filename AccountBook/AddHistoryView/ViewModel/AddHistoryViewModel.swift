//
//  AddHistoryViewModel.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/08.
//

import Foundation
import Combine

class AddHistoryViewModelWrapper: ObservableObject {
    private(set) var viewModel: AddHistoryViewModel
    @Published var incomeCategories = [Category]()
    @Published var spendingCategories = [Category]()
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: AddHistoryViewModel) {
        self.viewModel = viewModel
        viewModel.loadData()
        binding()
    }
    
    private func binding() {
        viewModel.$incomeCategories
            .sink { [weak self] category in
                self?.incomeCategories = category
            }
            .store(in: &cancellable)
        
        viewModel.$spendingCategories
            .sink { [weak self] category in
                self?.spendingCategories = category
            }
            .store(in: &cancellable)
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
