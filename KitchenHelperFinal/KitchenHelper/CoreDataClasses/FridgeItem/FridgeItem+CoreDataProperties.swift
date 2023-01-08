//
//  FridgeItem+CoreDataProperties.swift
//  KitchenHelper
//
//  Created by dfg on 04.11.2022.
//
//

import Foundation
import CoreData
import UIKit


extension FridgeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FridgeItem> {
        return NSFetchRequest<FridgeItem>(entityName: "FridgeItem")
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var overdueDate: Date?

}

extension FridgeItem : Identifiable {

}
