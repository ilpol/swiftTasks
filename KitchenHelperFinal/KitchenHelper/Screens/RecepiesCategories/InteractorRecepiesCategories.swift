//
//  InteractorRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit
import CoreData

protocol AnyInteractorRecepiesCategories {
    var presenter: AnyPresenterRecepiesCategories? {get set}
    func fetchRecepiesCategories()
    func onSearch(querry: String)
}

class InteractorRecepiesCategories: AnyInteractorRecepiesCategories {
    
    var savedCategories = [CategoryItem]()
    
    var presenter: AnyPresenterRecepiesCategories?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fridgeItems = [FridgeItem]()
    var networkService: NetworkServiceProtocol

    
    init() {
        self.networkService = NetworService.shared
    }
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
    
    func onSearch(querry: String) {
        do {
            let fetchRequest : NSFetchRequest<CategoryItem> = CategoryItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", querry)
            let fetchedResults = try context.fetch(fetchRequest)
          
            presenter?.onSeachResults(filteredCategories: categoryItemToCategory(items: fetchedResults))
            
            
        } catch {
            print("error searching")
        }
    }
    
    func fetchRecepiesCategories() {
        getAllItems()
        self.presenter?.onFetchedCategories(categories: categoryItemToCategory(items: savedCategories))
       
        networkService.fetchCategories() { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.presenter?.onFetchedCategories(categories: response.categories)
                self.deleteAllItems()
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
            print("error getting items")
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
            print("error creating item")
        }
    }
    
    func createItemImage(imageUrl: String, imageData: Data) {
        let newItem = DownloadedImage(context: context)
        newItem.imageUrlStr = imageUrl
        newItem.imageData = imageData
        do {
            try context.save()
        }
        catch {
            print("error creating itemImage")
        }
    }

    func deleteItem(item: CategoryItem) {
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            print("error deleting item")
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
            print("error deleting all items")
        }
        
    }
    func updateItem(item: CategoryItem, name: String) {
        item.name = name
        do {
            try context.save()
        }
        catch {
            print("error updating item")
        }
    }
    
    func deleteItem(item: FridgeItem) {
        
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("error deleting item")
        }
    }
}

