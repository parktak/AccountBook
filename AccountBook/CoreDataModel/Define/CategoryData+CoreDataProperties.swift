//
//  CategoryData+CoreDataProperties.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/29.
//
//

import Foundation
import CoreData


extension CategoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryData> {
        return NSFetchRequest<CategoryData>(entityName: "CategoryData")
    }

    @NSManaged public var code: String
    @NSManaged public var image: String
    @NSManaged public var title: String
    @NSManaged public var type: String

}

extension CategoryData : Identifiable {

}
