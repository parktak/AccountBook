//
//  AccountBookViewModel.swift
//  HouseholdAccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation


struct UIData {
    var date: String
    var list: [AccountData]
}

class AccountBookViewModel: ObservableObject {
    
    
    @Published private(set) var list = [AccountData]()
    @Published private(set) var hisotryDictionary = [String: UIData]()
    
    func loadData() {
        list = MockData.getAccountData()
        makeData()
        print("success to load")
    }
    
    private func makeData() {
        var dataDictionary = [String: UIData]()
        
        list.forEach { account in
            
            if dataDictionary[account.date] == nil {
                dataDictionary[account.date] = UIData(date: account.date, list: [account])
                return
            }
            
            dataDictionary[account.date]?.list.append(account)
        }
        
        hisotryDictionary = dataDictionary
    }
}
