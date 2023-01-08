//
//  InteractorFridge.swift
//  KitchenHelper
//
//  Created by dfg on 20.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyInteractorFridge {
    var presenter: AnyPresenterFridge? {get set}
    func fetchFridgeItems()
    func deleteItem(item: FridgeItem)
}

class FridgeInteractor: AnyInteractorFridge {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var presenter: AnyPresenterFridge?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fridgeItems = [FridgeItem]()

    
    init() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if (!permissionGranted) {
                print("Permisssion denied")
            }
        }
    }
    
    func fetchFridgeItems() {
        do {
            fridgeItems = try context.fetch(FridgeItem.fetchRequest())
            DispatchQueue.main.async {
                self.presenter?.onFetchedItems(fridgeItems: self.fridgeItems)
            }
        } catch {
            print("error fetching Fridge Items CoreData")
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
    
    func deleteAllItems() {
        do {
           let savedGoods = try context.fetch(FridgeItem.fetchRequest())
            for good in savedGoods {
                deleteItem(item: good)
            }
        }
        catch {
            print("error deleting items")
        }
    }
}

