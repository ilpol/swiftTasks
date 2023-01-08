//
//  RouterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

typealias EntryPointRecepiesCategories = AnyViewRecepiesCategories & UIViewController

protocol AnyRouterRecepiesCategories {
    static func start(view: RecepiesCategoriesViewController) -> Void
    var entry: EntryPointRecepiesCategories? {get}
    func toRecepiesCategoriesConstentScreen(categoryName: String)
}

class RouterRecepiesCategories: AnyRouterRecepiesCategories {
    
    static var recepiesCategoriesViewController =  RecepiesCategoriesViewController()
    
    var entry: EntryPointRecepiesCategories?
    
    func toRecepiesCategoriesConstentScreen(categoryName: String) {
        ConfigureNavigation.shared.openRecepiesCategoriesContent(from: RouterRecepiesCategories.recepiesCategoriesViewController, categoryName: categoryName)
    }

    static func start(view: RecepiesCategoriesViewController)-> Void {
        let router = RouterRecepiesCategories()
        
        var presenter: AnyPresenterRecepiesCategories = PresenterRecepiesCategories()
        var interactor: AnyInteractorRecepiesCategories = InteractorRecepiesCategories()
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        recepiesCategoriesViewController = view
        
        router.entry = view as EntryPointRecepiesCategories
        
        ConfigureNavigation.shared.openOnboarding(from: view)
    }
}
