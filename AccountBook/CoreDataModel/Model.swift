//
//  Model.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/24.
//

import Combine
import CoreData


class Model {
    static let shared = Model()
    static let accountHistory = AccountHistoryModel()
    static let category = CategoryModel()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AccountBook")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        }
        return container
    }()
    
    
    static func createBasicCategoriesIfNeed() {
        if !category.getCategoryDatas().isEmpty {
            return
        }
        
        MockData.getCategories().forEach {
            _ = category.insert($0)
        }
        
    }
}



protocol ModelBasicFunctions {}
extension ModelBasicFunctions {
    static func saveContext(_ context: NSManagedObjectContext) -> Bool {
        
        if !context.hasChanges {
            return true
        }
        
        do {
            try context.save()
            return true
            
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            return false
        }
    }
    
    static func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        let context = Model.shared.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

extension Model: ModelBasicFunctions { }
