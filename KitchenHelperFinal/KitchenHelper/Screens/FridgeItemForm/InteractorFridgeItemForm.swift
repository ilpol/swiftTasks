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
    func createItem(name: String, itemDescription: String, id: String, itemImage: UIImage, overdueDate: Date, isOverdueNotificationSwitch: Bool)
    
}

class FridgeItemFormInteractor: AnyInteractorFridgeItemForm {
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    
    func scheduleNotification (overdueDate: Date, id: String, name: String) {
        notificationCenter.getNotificationSettings {
            (settings) in
            DispatchQueue.main.async {
                
                let title = "Продукт \(name) просрочен"
                let message = ""
                
                if (settings.authorizationStatus == .authorized) {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: overdueDate)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                        if(error != nil) {
                            print("Error" + error.debugDescription)
                            return
                        }
                    }
                } else {
                    
                    let ac = UIAlertController(title: "Уведомления включены?", message: "Чтобы получать уведомления о просроченных продуктах включите разрешите уведомления в настройках", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default) {
                        (_) in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else {
                            return
                        }
                        if (UIApplication.shared.canOpenURL(settingsURL)) {
                            UIApplication.shared.open(settingsURL) {
                                (_) in
                            }
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_) in}))
                    self.presenter?.present(ac: ac, animated: true)
                    
                }
            }
        }
    }
    
    func createItem(name: String, itemDescription: String, id: String, itemImage: UIImage, overdueDate: Date, isOverdueNotificationSwitch: Bool) {
        
        let newItem = FridgeItem(context: context)
        newItem.name=name
        newItem.itemDescription = itemDescription
        newItem.id = id
        let imageData = itemImage.pngData()
        newItem.image = imageData
        newItem.overdueDate = overdueDate
        do {
            try context.save()
            if (isOverdueNotificationSwitch) {
                scheduleNotification(overdueDate: overdueDate, id: id, name: name)
                        }
        } catch {
            print("error saving it")
        }
    }
    
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
            print("error deleting item CoreData")
        }
    }
}


