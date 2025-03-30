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

enum AddHistoryUIChange {
    case successToAdd, failToAdd
}

class AddHistoryViewModelWrapper: ObservableObject {
    private(set) var viewModel: AddHistoryViewModel
    @Published var categories = [Category]()
    @Published private(set) var calculatorData = ""
    @Published private(set) var title = ""
    
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
        
        viewModel.$title
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancellable)
    }
 
}

class AddHistoryViewModel {
    
    @Published private(set) var incomeCategories = [Category]()
    @Published private(set) var spendingCategories = [Category]()
    @Published private(set) var calculatorData = ""
    @Published private(set) var title = ""
    private(set) var date = ""
    
    private var selectedCategory: Category?
    let subject = PassthroughSubject<AddHistoryUIChange, Never>()
    
    func loadData() {
        let categories = Model.category.getCategoryDatas()
        incomeCategories = categories.filter { $0.type == .income }
        spendingCategories = categories.filter { $0.type == .spending }
    }
    
    func removeLast() {
        calculatorData.removeLast()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func addCalcData(_ value: String) {
        
        if value == "=" {
            calculate()
            return
        }
        
        calculatorData += value
    }
    
    func selectCategory(_ category: Category) {
        selectedCategory = category
        print("category -> \(category.title)")
    }
    
    func add() {
        // 수식을 계산안했으면 먼저 계산해주고
        if calculatorData.contains("+") || calculatorData.contains("-") {
            calculate()
        }
        
        guard let amount = Float(self.calculatorData),
        let selectedCategory else {
            return
        }
        
        date = TimeUtil.today()
        let data = AccountHistory(id: TimeUtil.now(),
                                  type: selectedCategory.type,
                                  category: selectedCategory,
                                  title: self.title,
                                  amount: amount,
                                  date: date,
                                  memo: "")
        
        print(data)
        let result = Model.accountHistory.insert(data)
        
        result ? subject.send(.successToAdd) : subject.send(.failToAdd)
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
