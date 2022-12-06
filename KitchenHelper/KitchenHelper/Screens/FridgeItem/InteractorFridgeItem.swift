//
//  InteractorFridgeItem.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyInteractorFridgeItem {
    var presenter: AnyPresenterFridgeItem? {get set}
}

class FridgeItemInteractor: AnyInteractorFridgeItem {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var presenter: AnyPresenterFridgeItem?
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
