//
//  PresenterFridge.swift
//  KitchenHelper
//
//  Created by dfg on 20.11.2022.
//

import UIKit

protocol AnyPresenterFridge {
    var router: AnyRouterFridge? {get set}
    var interactor: AnyInteractorFridge? {get set}
    var view: AnyViewFridge? {get set}

    func onItemClick(fridgeItem: FridgeItem)
    func onLoadView()
    func onFetchedItems(fridgeItems: [FridgeItem])
    func deleteItem(item: FridgeItem)
    func addNewItem()
}

class FridgePresenter: AnyPresenterFridge {
        
    var router: AnyRouterFridge?
    var interactor: AnyInteractorFridge?

    var view: AnyViewFridge?
    
    func onItemClick(fridgeItem: FridgeItem) {
        router?.toFridgeItemScreen(fridgeItem: fridgeItem)
    }
    
    func onLoadView() {
        interactor?.fetchFridgeItems()
    }

    func onFetchedItems(fridgeItems: [FridgeItem]) {
        view?.loadFridgeItems(fridgeItems: fridgeItems)
    }
    
    func deleteItem(item: FridgeItem) {
        interactor?.deleteItem(item: item)
    }
    
    func addNewItem() {
        router?.toItemForm()
    }
}
