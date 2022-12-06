//
//  CategoryItem+CoreDataProperties.swift
//  KitchenHelper
//
//  Created by dfg on 27.11.2022.
//
//

import Foundation
import CoreData


extension CategoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryItem> {
        return NSFetchRequest<CategoryItem>(entityName: "CategoryItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var descriptionAtr: String?

}

extension CategoryItem : Identifiable {

}
