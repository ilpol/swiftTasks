//
//  RouterFridge.swift
//  KitchenHelper
//
//  Created by dfg on 20.11.2022.
//

import UIKit

protocol AnyRouterFridge {
    static func start(view: FridgeViewController) -> Void
    var entry: EntryPointFridge? {get}
    func toFridgeItemScreen(fridgeItem: FridgeItem) 
    func toItemForm()
}

typealias EntryPointFridge = AnyViewFridge & UIViewController

class FridgeRouter: AnyRouterFridge {
    
    var entry: EntryPointFridge?
    static var fridgeView:FridgeViewController?
    
    func toItemForm() {
        ConfigureNavigation.shared.openFridgeItemForm(from: FridgeRouter.fridgeView!)
    }
    
    func toFridgeItemScreen(fridgeItem: FridgeItem) {
        ConfigureNavigation.shared.openFridgeItem(from: FridgeRouter.fridgeView!, fridgeItem: fridgeItem)
    }

    static func start(view: FridgeViewController)-> Void {
        let router = FridgeRouter()
        
        var presenter: AnyPresenterFridge = FridgePresenter()
        var interactor: AnyInteractorFridge = FridgeInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        fridgeView = view
        
        router.entry = view
    }
}
