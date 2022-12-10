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
        fetchData(urlString: urlString, isDecode: true, completion: completion)
    }
    
    func fetchImageDataRaw(urlString: String, completion: @escaping (Result<Data, Error>) -> ()) {
        fetchData(urlString: urlString, isDecode: false, completion: completion)
    }
    
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> () ) {
        let savedImage = getItemByUrlUserDefaults(imageUrl: imageUrl)
        if (savedImage != nil) {
            completion(.success(savedImage!.imageData))
        }
        
        fetchImageDataRaw(urlString: imageUrl) { result in
            switch result {
            case .failure(let error):
                print("Error fetching images, \(error)")
            case .success(let response):
                completion(.success(response))
                self.updateImageUserDefaults(imageUrl: imageUrl, imageData: response)
            }
        }
    }
    
    fileprivate func fetchData<T: Decodable>(urlString: String, isDecode: Bool, completion: @escaping (Result<T, Error>) -> () ) {
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
    
    func updateImageUserDefaults(imageUrl: String, imageData: Data) {
        let defaults = UserDefaults.standard
        
        var imagesUserDefaults = getAllImageItemsUserDefaults()
        
        var isImageDataExist = false
        for imageUserDefaults in imagesUserDefaults {
            let str = (imageUserDefaults.imageUrlStr) as String

            if (str == imageUrl) {
                imageUserDefaults.imageData = imageData
                isImageDataExist = true
            }
        }
        
        if (!isImageDataExist) {
            
                let newImage = ImageEntity(imageUrlStrToSet: imageUrl, imageDataToSet: imageData)
                imagesUserDefaults.append(newImage)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(imagesUserDefaults) {
            defaults.set(encoded, forKey: "SavedImages")
        }
    }
    
    func getAllImageItemsUserDefaults() -> [ImageEntity] {

        let defaults = UserDefaults.standard
        if let savedImages = defaults.object(forKey: "SavedImages") as? Data {
            let decoder = JSONDecoder()
            if let loadedImages = try? decoder.decode(ImagesEntity.self, from: savedImages) {
                
                return loadedImages.images
            }
        }

        return []
    }
    
    func getItemByUrlUserDefaults(imageUrl: String) -> ImageEntity? {
        
        let imagesUserDefaults = getAllImageItemsUserDefaults()
        for imageUserDefaults in imagesUserDefaults {
            let savedStr = (imageUserDefaults.imageUrlStr) as String

            if (savedStr == imageUrl) {
                return imageUserDefaults
            }
        }
        
        return nil
    }
    
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
