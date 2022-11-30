//
//  RecepieCell.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import Foundation

class NetworService {

    static let shared = NetworService()
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> () ) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        fetchData(urlString: urlString, completion: completion)
    }
    
    fileprivate func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let data = data else { return }
            
            do {
                let decoded: T = try data.decoded()
                
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
