//
//  RouterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

typealias EntryPointRecepiesCategoriesContent = AnyViewRecepiesCategoriesContent & UIViewController

protocol AnyRouterRecepiesCategoriesContent {
    static func start(from: UIViewController, categoryName: String)-> Void
    var entry: EntryPointRecepiesCategoriesContent? {get}
    func toRecepiesDetailsScreen(id: String)
}

class RouterRecepiesCategoriesContent: AnyRouterRecepiesCategoriesContent {
    
    
    
    var entry: EntryPointRecepiesCategoriesContent?
    
    func toItemForm() {
    }
    
    func toRecepiesDetailsScreen(id: String) {
        ConfigureNavigation.shared.openRecepiesDetails(from: RouterRecepiesCategories.recepiesCategoriesViewController, id: id)
    }

    static func start(from: UIViewController, categoryName: String)-> Void {
        let router = RouterRecepiesCategoriesContent()
        
        var view: AnyViewRecepiesCategoriesContent = RecepiesCategoriesContentViewController()
        var presenter: AnyPresenterRecepiesCategoriesContent = PresenterRecepiesCategoriesContent()
        var interactor: AnyInteractorRecepiesCategoriesContent = InteractorRecepiesCategoriesContent()
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        view.setCategoryName(name: categoryName)
        
        router.entry = view as? EntryPointRecepiesCategoriesContent
        
        from.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}




