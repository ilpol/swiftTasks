//
//  RecepieCell.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> () )
    
}

class NetworService: NetworkServiceProtocol {

    static let shared = NetworService()
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> () ) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        fetchData(urlString: urlString, isDecode: true, completion: completion)
    }
    
    func fetchImageDataRaw(urlString: String, completion: @escaping (Result<Data, Error>) -> ()) {
        fetchData(urlString: urlString, isDecode: false, completion: completion)
    }
    
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> () ) {
        let savedImage = getItemByUrlCoreData(imageUrl: imageUrl)
        completion(.success(savedImage.imageData ?? Data()))
        
        fetchImageDataRaw(urlString: imageUrl) { result in
            switch result {
            case .failure(let error):
                print("Error fetching images, \(error)")
            case .success(let response):
                completion(.success(response))
                self.updateImageCoreData(imageUrl: imageUrl, imageData: response)
            }
        }
    }
    
    func fetchData<T: Decodable>(urlString: String, isDecode: Bool, completion: @escaping (Result<T, Error>) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let data = data else { return }
            
            do {
                if (isDecode) {
                    let decoded: T = try data.decoded()
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success(data as! T))
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func updateImageCoreData(imageUrl: String, imageData: Data) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let imageCoreData = getItemByUrlCoreData(imageUrl: imageUrl)
        imageCoreData.imageData = imageData
        do {
            try context.save()
        }
        catch {
        }
    }
    
    func getAllImageItemsCoreData() -> [DownloadedImage] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          let savedImages = try context.fetch(DownloadedImage.fetchRequest())
            return savedImages
        }
        catch {
            
        }
        return []
    }
    
    func getItemByUrlCoreData(imageUrl: String) -> DownloadedImage {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          let imagesCoreData = getAllImageItemsCoreData()
            for imageCoreData in imagesCoreData {
                let str = (imageCoreData.imageUrlStr ?? "") as String

                if (str == imageUrl) {
                    return imageCoreData
                }
            }
            let newItem = DownloadedImage(context: context)
            newItem.imageUrlStr = imageUrl
            newItem.imageData = Data()
            return newItem
        }
    }
    
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
