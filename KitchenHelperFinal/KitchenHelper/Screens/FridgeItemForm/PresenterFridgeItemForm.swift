//
//  PresenterFridgeItemForm.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit

protocol AnyPresenterFridgeItemForm {
    var router: AnyRouterFridgeItemForm? {get set}
    var interactor: AnyInteractorFridgeItemForm? {get set}
    var view: AnyViewFridgeItemForm? {get set}
    func createItem(name: String, itemDescription: String, id: String, itemImage: UIImage, overdueDate: Date, isOverdueNotificationSwitch: Bool)
    func present(ac: UIAlertController, animated: Bool)
}

class FridgeItemFormPresenter: AnyPresenterFridgeItemForm {
        
    var router: AnyRouterFridgeItemForm?
    var interactor: AnyInteractorFridgeItemForm?

    var view: AnyViewFridgeItemForm?
    
    func present(ac: UIAlertController, animated: Bool) {
        view?.present(ac: ac, animated: animated)
    }
    
    func createItem(name: String, itemDescription: String, id: String, itemImage: UIImage, overdueDate: Date, isOverdueNotificationSwitch overdueNotificationSwitch: Bool) {
        interactor?.createItem(name: name, itemDescription: itemDescription, id: id, itemImage: itemImage, overdueDate: overdueDate, isOverdueNotificationSwitch: overdueNotificationSwitch)
    }
}
