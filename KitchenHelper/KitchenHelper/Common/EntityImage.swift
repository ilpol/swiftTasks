//
//  EntityImage.swift
//  KitchenHelper
//
//  Created by dfg on 06.12.2022.
//

import Foundation

import Foundation

class ImageEntity: Codable {
    var imageUrlStr: String
    var imageData: Data
    
    enum ConfigKeys: String, CodingKey {
        case imageUrlStr
        case imageData
    }
    
    init(imageUrlStrToSet: String, imageDataToSet: Data) {
        imageUrlStr = imageUrlStrToSet
        imageData = imageDataToSet
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrlStr = try values.decodeIfPresent(String.self, forKey: .imageUrlStr)!
        self.imageData = try values.decodeIfPresent(Data.self, forKey: .imageData)!
    }
    
}


class ImagesEntity: Decodable, Encodable {
  let images: [ImageEntity]
}

