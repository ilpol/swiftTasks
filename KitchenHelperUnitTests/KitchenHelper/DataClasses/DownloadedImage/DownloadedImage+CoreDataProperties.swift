//
//  DownloadedImage+CoreDataProperties.swift
//  KitchenHelper
//
//  Created by dfg on 04.12.2022.
//
//

import Foundation
import CoreData


extension DownloadedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadedImage> {
        return NSFetchRequest<DownloadedImage>(entityName: "DownloadedImage")
    }

    @NSManaged public var imageUrlStr: String?
    @NSManaged public var imageData: Data?

}

extension DownloadedImage : Identifiable {

}
