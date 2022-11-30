//
//  InteractorFridgeItemForm.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyInteractorFridgeItemForm {
    var presenter: AnyPresenterFridgeItemForm? {get set}
    
}

class FridgeItemFormInteractor: AnyInteractorFridgeItemForm {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var presenter: AnyPresenterFridgeItemForm?
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


