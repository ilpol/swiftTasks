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
    func categoryItemToCategory(items: [CategoryItem]) -> [Category] {
        var categoryItems = [Category]()
        for item in items {
            let categoryItem = Category (
                id: item.id ?? "",
                name: item.name ?? "",
                imageUrl: item.imageUrl ?? "",
                description: item.descriptionAtr ?? ""
            )
            
            categoryItems.append(categoryItem)
        }
        return categoryItems
    }
    
    func fetchRecepiesCategories() {
        getAllItems()
        self.presenter?.onFetchedCategories(categories: categoryItemToCategory(items: savedCategories))
        NetworService.shared.fetchCategories() { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.deleteAllItems()
                self.presenter?.onFetchedCategories(categories: response.categories)
                for category in response.categories {
                    self.createItem(id: category.id, name: category.name, imageUrl: category.imageUrl, descriptionAtr: category.description)
                }
            }
        }
        
    }
    
    func getAllItems() {
        do {
        savedCategories = try context.fetch(CategoryItem.fetchRequest())
        }
        catch {
            
        }
        
    }
    
    func onSearch(querry: String) {
        do {
            let fetchRequest : NSFetchRequest<CategoryItem> = CategoryItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", querry)
            let fetchedResults = try context.fetch(fetchRequest)
          
            presenter?.onSeachResults(filteredCategories: categoryItemToCategory(items: fetchedResults))
            
            
        } catch {
            
        }
        
    }
    func createItem(id: String, name: String, imageUrl: String, descriptionAtr: String) {
        let newItem = CategoryItem(context: context)
        newItem.id = id
        newItem.name = name
        newItem.imageUrl = imageUrl
        newItem.descriptionAtr = descriptionAtr
        do {
            try context.save()
        }
        catch {
            
        }
        
        
    }
    func deleteItem(item: CategoryItem) {
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            
        }
        
    }
    func deleteAllItems() {
        do {
           savedCategories = try context.fetch(CategoryItem.fetchRequest())
            for category in savedCategories {
                deleteItem(item: category)
            }
        }
        catch {
            
        }
        
    }
    func updateItem(item: CategoryItem, name: String) {
        item.name = name
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: FridgeItem) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [item.id ?? ""])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id ?? ""])
        
        context.delete(item)
        do {
            try context.save()
        } catch {
            
        }
    }
}

