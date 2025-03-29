//
//  HistoryData+CoreDataProperties.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/29.
//
//

import Foundation
import CoreData


extension HistoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryData> {
        return NSFetchRequest<HistoryData>(entityName: "HistoryData")
    }

    @NSManaged public var amount: Float
    @NSManaged public var categoryId: String
    @NSManaged public var date: String
    @NSManaged public var id: String
    @NSManaged public var memo: String
    @NSManaged public var title: String
    @NSManaged public var type: String

}

extension HistoryData : Identifiable {

}
