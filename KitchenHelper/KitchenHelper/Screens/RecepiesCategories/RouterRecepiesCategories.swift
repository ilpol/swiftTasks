//
//  RouterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

typealias EntryPointRecepiesCategories = AnyViewRecepiesCategories & UIViewController

protocol AnyRouterRecepiesCategories {
    static func start(view: RecepiesCategoriesViewController) -> AnyRouterRecepiesCategories
    var entry: EntryPointRecepiesCategories? {get}
}

class RouterRecepiesCategories: AnyRouterRecepiesCategories {
    
    var entry: EntryPointRecepiesCategories?
    
    func toItemForm() {
    }

    static func start(view: RecepiesCategoriesViewController)-> AnyRouterRecepiesCategories {
        let router = RouterRecepiesCategories()
        
        //var view: AnyViewFridge = FridgeViewController()
        var presenter: AnyPresenterRecepiesCategories = PresenterRecepiesCategories()
        var interactor: AnyInteractorRecepiesCategories = InteractorRecepiesCategories()
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPointRecepiesCategories
        
        return router
    }
}




