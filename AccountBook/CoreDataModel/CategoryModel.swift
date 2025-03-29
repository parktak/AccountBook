//
//  CategoryModel.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/29.
//

import Foundation
import CoreData

class CategoryModel {
    
    private var context: NSManagedObjectContext {
        Model.shared.persistentContainer.viewContext
    }
    
    func insert(_ data: Category) -> Bool {
        
        let entity = NSEntityDescription.entity(forEntityName: "CategoryData", in: context)
        
        guard let entity  else { return false }
        
        let history = NSManagedObject(entity: entity, insertInto: context)
        history.setValue(data.code, forKey: "code")
        history.setValue(data.image, forKey: "image")
        history.setValue(data.title, forKey: "title")
        history.setValue(data.type.rawValue, forKey: "type")
        
        return Model.saveContext(context)
    }
    
    func getCategoryDatas() -> [Category] {
        
        guard let result = try? context.fetch(CategoryData.fetchRequest()) as? [CategoryData] else {
            return []
        }
        
        return result.map { $0.toCategory() }
    }
}

extension CategoryData {
    func toCategory() -> Category {
        return Category(type: SpendType(rawValue: self.type) ?? .spending,
                        code: self.code,
                        title: self.title,
                        image: self.image
        )
    }
}
