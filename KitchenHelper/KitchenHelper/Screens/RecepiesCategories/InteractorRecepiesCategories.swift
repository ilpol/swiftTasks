//
//  InteractorRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit
import Vision
import UserNotifications
import CoreData

protocol AnyInteractorRecepiesCategories {
    var presenter: AnyPresenterRecepiesCategories? {get set}
    func fetchRecepiesCategories()
    func onSearch(querry: String)
}

class InteractorRecepiesCategories: AnyInteractorRecepiesCategories {
    
    let defaults = UserDefaults.standard
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var savedCategories = [CategoryItem]()
    
    var presenter: AnyPresenterRecepiesCategories?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fridgeItems = [FridgeItem]()

    
    init() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if (!permissionGranted) {
                print("Permisssion denied")
            }
        }
    }
    
    func onSearch(querry: String) {
        if let savedCategories = defaults.object(forKey: "SavedCategories") as? Data {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode(CategoriesResponse.self, from: savedCategories) {
                var res = [Category]()
                for category in loadedCategories.categories {
                    if (category.name.contains(querry)) {
                        res.append(category)
                    }
                }
                self.presenter?.onFetchedCategories(categories: res)
            }
        }
    }
    
    func fetchRecepiesCategories() {
        if let savedCategories = defaults.object(forKey: "SavedCategories") as? Data {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode(CategoriesResponse.self, from: savedCategories) {
                self.presenter?.onFetchedCategories(categories: loadedCategories.categories)
            }
        }

        NetworService.shared.fetchCategories() { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.presenter?.onFetchedCategories(categories: response.categories)
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(response) {
                    self.defaults.set(encoded, forKey: "SavedCategories")
                }
            }
        }
        
    }

}

