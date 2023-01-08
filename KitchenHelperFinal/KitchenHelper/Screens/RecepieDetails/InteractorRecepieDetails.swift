//
//  InteractorRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit
import CoreData

protocol AnyInteractorRecepieDetails {
    var presenter: AnyPresenterRecepieDetails? {get set}
    func fetchRecepieDetails(id: String)
}

class InteractorRecepieDetails: AnyInteractorRecepieDetails {
    var savedCategories = [RecepieDetailsContent]()
    
    var presenter: AnyPresenterRecepieDetails?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fridgeItems = [FridgeItem]()
    var networkService: NetworkServiceProtocol

    
    init() {
        self.networkService = NetworService.shared
    }
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func categoryItemToCategory(items: [RecepieDetailsContent]) -> [RecepieDetails] {
        var categoryItems = [RecepieDetails]()
        for item in items {
            let categoryItem = RecepieDetails (
                id: item.id ?? "",
                name: item.name ?? "",
                imageUrl: item.imageUrl ?? "",
                category: item.category ?? "",
                area: item.area ?? "", instructions: item.instructions ?? "",
                tagsString: item.tagsString ?? "", youtubeUrlString: item.youtubeUrlString ?? "",
                ingredient1:  item.ingredient1 ?? "",
                ingredient2:  item.ingredient2 ?? "",
                ingredient3:  item.ingredient3 ?? "",
                ingredient4:  item.ingredient4 ?? "",
                ingredient5:  item.ingredient5 ?? "",
                ingredient6:  item.ingredient6 ?? "",
                ingredient7:  item.ingredient7 ?? ""
            )
            
            categoryItems.append(categoryItem)
        }
        return categoryItems
    }
    
    
    func fetchRecepieDetails(id: String) {
        getAllItems()
        if (savedCategories.count != 0) {
            self.presenter?.onFetchedRecepieDetails(recepieDetails: categoryItemToCategory(items: savedCategories))
        }
       
        networkService.fetchRecepieDetails(for: id) { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.presenter?.onFetchedRecepieDetails(recepieDetails: response.meals)
                self.deleteAllItems()
                for category in response.meals {
                    self.createItem(id: category.id, name: category.name, imageUrl: category.imageUrl, category: category.category,
                                    area: category.area,
                                    instructions: category.instructions,
                                    tagsString: category.tagsString ?? "",
                                    youtubeUrlString: category.youtubeUrlString ,
                                    ingredient1: category.ingredient1 ?? "",
                                    ingredient2: category.ingredient2 ?? "",
                                    ingredient3: category.ingredient3 ?? "",
                                    ingredient4: category.ingredient4 ?? "",
                                    ingredient5: category.ingredient5 ?? "",
                                    ingredient6: category.ingredient6 ?? "",
                                    ingredient7: category.ingredient7 ?? "")
                                }
            }
        }
        
    }
    
    func getAllItems() {
        do {
        savedCategories = try context.fetch(RecepieDetailsContent.fetchRequest())
        }
        catch {
            print("error getting all items")
        }
    }

    func createItem(id: String, name: String, imageUrl: String, category: String,
            area: String,
            instructions: String,
            tagsString: String,
            youtubeUrlString: String,
            ingredient1: String,
            ingredient2: String,
            ingredient3: String,
            ingredient4: String,
            ingredient5: String,
            ingredient6: String,
            ingredient7: String) {
        let newItem = RecepieDetailsContent(context: context)
        newItem.id = id
        newItem.name = name
        newItem.area = area
        newItem.imageUrl = imageUrl
        newItem.category = category
        newItem.instructions = instructions
        newItem.tagsString = tagsString
        newItem.youtubeUrlString = youtubeUrlString
            
        newItem.ingredient1 = ingredient1
        newItem.ingredient2 = ingredient2
        newItem.ingredient3 = ingredient3
        newItem.ingredient4 = ingredient4
        newItem.ingredient5 = ingredient5
        newItem.ingredient6 = ingredient6
        newItem.ingredient7 = ingredient7
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
            print("error creating item image CoreData")
        }
    }

    func deleteItem(item: RecepieDetailsContent) {
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
           savedCategories = try context.fetch(RecepieDetailsContent.fetchRequest())
            for category in savedCategories {
                deleteItem(item: category)
            }
        }
        catch {
            print("error deleting all items CoreData")
        }
        
    }
    func updateItem(item: RecepieDetailsContent, name: String) {
        item.name = name
        do {
            try context.save()
        }
        catch {
            print("error updating item CoreData")
        }
    }
    
    func deleteItem(item: FridgeItem) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [item.id ?? ""])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id ?? ""])
        
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("error deleting item CoreData")
        }
    }
}

