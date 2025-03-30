//
//  AccountBookViewModel.swift
//  HouseholdAccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation
import Combine

struct UIData {
    var date: String
    var list: [AccountHistory]
}

class AccountBookViewModel: ObservableObject {
    
    
    private(set) var list = [AccountHistory]()
    @Published private(set) var hisotryDictionary = [String: UIData]()
    private var categoryDict = [String: Category]()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        Model.accountHistory.modelChangeSubject
            .sink { [weak self] change in
                switch change {
                case .insert(let new):
                    self?.addHistory(new)
                default: break
                }
            }
            .store(in: &cancellable)
    }
    
    func loadData() {
        let categories = Model.category.getCategoryDatas()
        categoryDict = [String: Category]()
        
        for category in categories {
            categoryDict[category.code] = category
        }
        
        list = Model.accountHistory.getHistories().map {
            $0.toHistoryData(categoryDict[$0.categoryId]!)
        }
    
        makeData()
        print("success to load")
    }
    
    private func makeData() {
        var dataDictionary = [String: UIData]()
        
        list.forEach { history in
            
            if dataDictionary[history.date] == nil {
                dataDictionary[history.date] = UIData(date: history.date, list: [history])
                return
            }
            
            dataDictionary[history.date]?.list.append(history)
        }
        
        hisotryDictionary = dataDictionary
    }
    
    private func addHistory(_ history: AccountHistory) {
        list.append(history)
        if hisotryDictionary[history.date] == nil {
            hisotryDictionary[history.date] = UIData(date: history.date, list: [history])
        } else {
            hisotryDictionary[history.date]?.list.append(history)
        }
        print("count -> \(list.count)")
        
    }
}
