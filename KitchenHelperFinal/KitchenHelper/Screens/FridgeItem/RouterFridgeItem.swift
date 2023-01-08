//
//  RouterFridgeItem.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit

protocol AnyRouterFridgeItem {
    static func start(from: UIViewController, fridgeItem: FridgeItem) -> Void
    var entry: EntryPointFridgeItem? {get}
    func toItemForm()
}

typealias EntryPointFridgeItem = AnyViewFridgeItem & UIViewController

class FridgeItemRouter: AnyRouterFridgeItem {
    
    var entry: EntryPointFridgeItem?
    static var fridgeView:FridgeViewController?
    
    func toItemForm() {
        ConfigureNavigation.shared.openFridgeItemForm(from: FridgeRouter.fridgeView!)
    }

    static func start(from prevView: UIViewController, fridgeItem: FridgeItem)-> Void {
        let router = FridgeItemRouter()
        
        var view: AnyViewFridgeItem = FridgeItemViewController()
        var presenter: AnyPresenterFridgeItem = FridgeItemPresenter()
        var interactor: AnyInteractorFridgeItem = FridgeItemInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.onOpenFridgeItem(fridgeItem: fridgeItem)
        
        router.entry = view as? EntryPointFridgeItem
        
        prevView.navigationController?.pushViewController(view as! UIViewController, animated: true)

    }
}
