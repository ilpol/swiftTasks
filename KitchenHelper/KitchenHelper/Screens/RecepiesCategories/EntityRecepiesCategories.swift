//
//  EntityRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import Foundation

struct Category: Decodable, Encodable {
    let id: String
    let name: String
    let imageUrl: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageUrl = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct CategoriesResponse: Decodable, Encodable {
    let categories: [Category]
}
