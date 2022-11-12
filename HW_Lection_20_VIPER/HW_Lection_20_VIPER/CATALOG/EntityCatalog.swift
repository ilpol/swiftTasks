//
//  Entity.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 11.11.2022.
//

import Foundation

struct Fruit: Codable {
    let name: String
}

enum FetchCatalogError: Error {
    case failed
}

