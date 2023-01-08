//
//  PresenterFridgeItem.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

protocol AnyPresenterFridgeItem {
    var router: AnyRouterFridgeItem? {get set}
    var interactor: AnyInteractorFridgeItem? {get set}
    var view: AnyViewFridgeItem? {get set}

    func onOpenFridgeItem(fridgeItem: FridgeItem)
    //func onOpenFridge()
    func onLoadView()
}

class FridgeItemPresenter: AnyPresenterFridgeItem {

    
        
    var router: AnyRouterFridgeItem?
    var interactor: AnyInteractorFridgeItem?

    var view: AnyViewFridgeItem?
    
    func onOpenFridgeItem(fridgeItem: FridgeItem) {
        view?.update(fridgeItem: fridgeItem)
    }
    
    func onLoadView() {
    }
    
    func onFetchedItems(fridgeItems: [FridgeItem]) {
    }
    
    func deleteItem(item: FridgeItem) {
    }
    
    func addNewItem() {
        router?.toItemForm()
    }
    
}
