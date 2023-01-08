//
//  EntityRecepiesCategoriesContent.swift
//  KitchenHelper
//
//  Created by dfg on 30.12.2022.
//

import Foundation

struct CategoryContent: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}

struct CategoryContentResponse: Decodable {
    let meals: [CategoryContent]
}

