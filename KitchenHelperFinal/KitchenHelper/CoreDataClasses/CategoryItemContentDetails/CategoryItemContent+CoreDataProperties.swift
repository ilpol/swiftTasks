//
//  CategoryItemContent+CoreDataProperties.swift
//  KitchenHelper
//
//  Created by dfg on 07.01.2023.
//
//

import Foundation
import CoreData


extension CategoryItemContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryItemContent> {
        return NSFetchRequest<CategoryItemContent>(entityName: "CategoryItemContent")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?

}

extension CategoryItemContent : Identifiable {

}
