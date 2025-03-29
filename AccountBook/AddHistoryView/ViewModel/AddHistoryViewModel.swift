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
    @Published private(set) var calculatorData = ""
    
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
        
        viewModel.$calculatorData
            .sink { [weak self] calcData in
                self?.calculatorData = calcData
            }
            .store(in: &cancellable)
    }
    
}

class AddHistoryViewModel {
    
    @Published private(set) var incomeCategories = [Category]()
    @Published private(set) var spendingCategories = [Category]()
    @Published private(set) var calculatorData = ""
    
    func loadData() {
        let categories = Model.category.getCategoryDatas()
        incomeCategories = categories.filter { $0.type == .income }
        spendingCategories = categories.filter { $0.type == .spending}
        
    }
    
    func removeLast() {
        calculatorData.removeLast()
    }
    
    func addCalcData(_ value: String) {
        
        if value == "=" {
            calculate()
            return
        }
        
        calculatorData += value
    }
    
    private func calculate() {
        
        guard let regex = try? NSRegularExpression(pattern: "([+-])", options: []) else {
            return
        }
        let datas = regex.split(string: calculatorData)
        
        if datas.isEmpty {
            return
        }
        
        var isSum = true

        
        let result = datas.reduce(0) { result, data -> Float in
            if ["+", "-"].contains(data) {
                isSum = data == "+"
                return result
            }
            
            guard let floatValue = Float(data) else {
                return result
            }
            
            return isSum ? result + floatValue : result - floatValue
        }
        
        let iResult = Int(result)
        calculatorData = result - Float(iResult) > 0 ? "\(result)" : "\(iResult)"
    }
}
