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
            print("\(error)")
        }
        return Data() as! T
    }
    
}
