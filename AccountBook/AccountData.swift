//
//  AccountData.swift
//  HouseholdAccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import Foundation


enum SpendType {
    case income, spending
}

struct AccountData: Identifiable, Hashable {
//    static func == (lhs: AccountData, rhs: AccountData) -> Bool {
//        lhs.id == rhs.id
//    }
//   
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
    var id: String = ""
    var type: SpendType = .spending
    var category = Category()
    var title = ""
    var amount = 0
    var date = ""
    var memo = ""
    var money: Int { get {
        type == .spending ? (amount * -1) : amount
    }}
}

struct Category: Identifiable, Hashable {
    var id: String { code }
    
    var type: SpendType = .spending
    var code = ""
    var title = ""
    var image = ""
}

class AccountModel {
    
}

class MockData {
    static func getAccountData() -> [AccountData] {
        let categories = getCategories()
        
        return [
            AccountData(id: "acc1", type: .income, category: categories[0], title: "드디어월급", amount: 1000000, date: "2025-02-22", memo: "순삭"),
            AccountData(id: "acc2", type: .spending, category: categories[1], title: "밥은 먹어야지!", amount: 10000, date: "2025-02-25", memo: ""),
            AccountData(id: "acc3", type: .spending, category: categories[2], title: "좋아서 술", amount: 50000, date: "2025-02-22", memo: "뇸뇸"),
            AccountData(id: "acc4", type: .spending, category: categories[2], title: "안좋아서 술", amount: 40000, date: "2025-02-21", memo: ""),
            ]
    }
    
    static func getCategories() -> [Category] {
        [
            Category(type: .income, code: "cate1", title: "월급", image: "salary"),
            Category(type: .spending, code: "cate2", title: "식비", image: "food"),
            Category(type: .spending, code: "cate3", title: "술", image: "soju"),
            Category(type: .income, code: "cate4", title: "주식", image: "salary"),
            Category(type: .spending, code: "cate5", title: "군것질", image: "food"),
            Category(type: .spending, code: "cate6", title: "야식", image: "soju"),
            Category(type: .income, code: "cate7", title: "배민알바", image: "salary"),
            Category(type: .spending, code: "cate8", title: "쇼핑", image: "food"),
            Category(type: .spending, code: "cate9", title: "그냥", image: "soju")
        
        ]
    }
}
