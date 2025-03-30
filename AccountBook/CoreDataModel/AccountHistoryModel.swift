//
//  AccountHistory+CoreDataClass.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/24.
//
//

import Combine
import CoreData

enum AccountModelEvent {
    case insert(AccountHistory), delete(AccountHistory), update(AccountHistory)
}

class AccountHistoryModel {
    
    let modelChangeSubject = PassthroughSubject<AccountModelEvent, Never>()
    private var context: NSManagedObjectContext {
        Model.shared.persistentContainer.viewContext
    }
    
    func insert(_ data: AccountHistory) -> Bool {
        
        let entity = NSEntityDescription.entity(forEntityName: "HistoryData", in: context)
        
        guard let entity  else { return false }
        
        let history = NSManagedObject(entity: entity, insertInto: context)
        history.setValue(data.title, forKey: "title")
        history.setValue(data.amount, forKey: "amount")
        history.setValue(data.category.code, forKey: "categoryId")
        history.setValue(data.date, forKey: "date")
        history.setValue(data.memo, forKey: "memo")
        history.setValue(data.type.rawValue, forKey: "type")
        history.setValue(data.id, forKey: "id")
        modelChangeSubject.send(.insert(data))
        return Model.saveContext(context)
    }
    
    func getHistories() -> [HistoryData] {
        
        guard let result = try? context.fetch(HistoryData.fetchRequest()) as? [HistoryData] else {
            return []
        }
        
        return result
    }
}

extension HistoryData {
    func toHistoryData(_ category: Category) -> AccountHistory {
        
        return AccountHistory(id: self.id,
                              type: SpendType(rawValue: self.type) ?? .spending,
                              category: category, 
                              title: self.title, amount: self.amount,
                              date: self.date,
                              memo: self.memo)
        
        
    }
}
