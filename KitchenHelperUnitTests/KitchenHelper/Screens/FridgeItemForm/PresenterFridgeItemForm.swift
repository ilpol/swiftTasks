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

    func onOpenFridge()
    func onLoadView()
}

class FridgeItemFormPresenter: AnyPresenterFridgeItemForm {
        
    var router: AnyRouterFridgeItemForm?
    var interactor: AnyInteractorFridgeItemForm?

    var view: AnyViewFridgeItemForm?
    
    func onOpenFridge() {
    }
    
    func onLoadView() {
    }
}


