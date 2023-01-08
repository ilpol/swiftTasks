//
//  InteractorRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit
import CoreData

protocol AnyInteractorRecepiesCategoriesContent {
    var presenter: AnyPresenterRecepiesCategoriesContent? {get set}
    func fetchRecepiesCategoryContent(categoryName: String)
    func onSearch(querry: String)
}

class InteractorRecepiesCategoriesContent: AnyInteractorRecepiesCategoriesContent {
    var savedCategories = [CategoryItemContent]()
    
    var presenter: AnyPresenterRecepiesCategoriesContent?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fridgeItems = [FridgeItem]()
    var networkService: NetworkServiceProtocol

    
    init() {
        self.networkService = NetworService.shared
    }
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    func categoryItemToCategory(items: [CategoryItemContent]) -> [CategoryContent] {
        var categoryItems = [CategoryContent]()
        for item in items {
            let categoryItem = CategoryContent (
                id: item.id ?? "",
                name: item.name ?? "",
                imageUrl: item.imageUrl ?? ""
            )
            
            categoryItems.append(categoryItem)
        }
        return categoryItems
    }
    
    func onSearch(querry: String) {
        do {
            let fetchRequest : NSFetchRequest<CategoryItemContent> = CategoryItemContent.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", querry)
            let fetchedResults = try context.fetch(fetchRequest)
          
            presenter?.onSeachResults(filteredCategories: categoryItemToCategory(items: fetchedResults))
            
            
        } catch {
            print("error searching")
        }
    }
    
    func fetchRecepiesCategoryContent(categoryName: String) {
        getAllItems()
        self.presenter?.onFetchedCategoryContent(categoryContent: categoryItemToCategory(items: savedCategories))
       
        networkService.fetchCategoryContent(for: categoryName) { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.presenter?.onFetchedCategoryContent(categoryContent: response.meals)
                self.deleteAllItems()
                for category in response.meals {
                    self.createItem(id: category.id, name: category.name, imageUrl: category.imageUrl)
                                }
            }
        }
        
    }
    
    func getAllItems() {
        do {
        savedCategories = try context.fetch(CategoryItemContent.fetchRequest())
        }
        catch {
            print("error getting all items CoreData")
        }
    }

    func createItem(id: String, name: String, imageUrl: String) {
        let newItem = CategoryItemContent(context: context)
        newItem.id = id
        newItem.name = name
        newItem.imageUrl = imageUrl

        do {
            try context.save()
        }
        catch {
            print("error creating item CoreData")
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
            print("error creating image CoreData")
        }
    }

    func deleteItem(item: CategoryItemContent) {
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            print("error deleting item CoreData")
        }
    }
    func deleteAllItems() {
        do {
           savedCategories = try context.fetch(CategoryItemContent.fetchRequest())
            for category in savedCategories {
                deleteItem(item: category)
            }
        }
        catch {
            print("error deleting all items CoreData")
        }
        
    }
    func updateItem(item: CategoryItemContent, name: String) {
        item.name = name
        do {
            try context.save()
        }
        catch {
            print("error updating item CoreData")
        }
    }
    
    func deleteItem(item: FridgeItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("error deleting all items CoreData")
        }
    }
}

