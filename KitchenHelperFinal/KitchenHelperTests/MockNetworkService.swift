//
//  MockNetworkService.swift
//  KitchenHelperTests
//
//  Created by dfg on 13.12.2022.
//

import Foundation


final class MockNetworkService: NetworkServiceProtocol {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> ()) {
        completion(.success(loadJSON(filename: "MockCategoriesRequest", type: CategoriesResponse.self)))
    }
    
    func fetchRecepieDetails(for id: String, completion: @escaping (Result<RecepieDetailsResponse, Error>) -> () ) {
        
    }
    
    func fetchCategoryContent(for category: String, completion: @escaping (Result<CategoryContentResponse, Error>) -> () ) {
        completion(.success(loadJSON(filename: "MockCategoriesContentRequest", type: CategoryContentResponse.self)))
        
    }
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            
            return decodedObject
        } catch {
            print("error loading json \(error)")
        }
        return Data() as! T
    }
    
}
