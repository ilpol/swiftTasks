//
//  RecepieDetailsContent+CoreDataProperties.swift
//  KitchenHelper
//
//  Created by dfg on 07.01.2023.
//
//

import Foundation
import CoreData


extension RecepieDetailsContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecepieDetailsContent> {
        return NSFetchRequest<RecepieDetailsContent>(entityName: "RecepieDetailsData")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var category: String?
    @NSManaged public var area: String?
    @NSManaged public var instructions: String?
    @NSManaged public var tagsString: String?
    @NSManaged public var youtubeUrlString: String?
    @NSManaged public var ingredient1: String?
    @NSManaged public var ingredient2: String?
    @NSManaged public var ingredient3: String?
    @NSManaged public var ingredient4: String?
    @NSManaged public var ingredient5: String?
    @NSManaged public var ingredient6: String?
    @NSManaged public var ingredient7: String?

}

extension RecepieDetailsContent : Identifiable {

}
