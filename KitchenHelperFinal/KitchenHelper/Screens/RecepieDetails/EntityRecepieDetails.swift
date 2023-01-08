//
//  EntityRecepiesCategoriesContent.swift
//  KitchenHelper
//
//  Created by dfg on 30.12.2022.
//

import Foundation

struct RecepieDetails: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let category: String
    let area: String
    let instructions: String
    let tagsString: String?
    let youtubeUrlString: String
    
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case tagsString = "strTags"
        case youtubeUrlString = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
    }
}

struct RecepieDetailsResponse: Decodable {
    let meals: [RecepieDetails]
}

