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
    private var fridgeItems = [FridgeItem]()

    
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

