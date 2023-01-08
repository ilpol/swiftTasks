//
//  RouterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

typealias EntryPointRecepieDetails = AnyViewRecepieDetails & UIViewController

protocol AnyRouterRecepieDetails {
    static func start(from: UIViewController, id: String)-> Void
    var entry: EntryPointRecepieDetails? {get}
}

class RouterRecepieDetails: AnyRouterRecepieDetails {
    
    
    
    var entry: EntryPointRecepieDetails?
    
    func toItemForm() {
    }

    static func start(from: UIViewController, id: String)-> Void {
        let router = RouterRecepieDetails()
        
        var view: AnyViewRecepieDetails = RecepieDetailsViewController()
        var presenter: AnyPresenterRecepieDetails = PresenterRecepieDetails()
        var interactor: AnyInteractorRecepieDetails = InteractorRecepieDetails()
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        view.setRecepieId(idToSet: id)
        
        router.entry = view as? EntryPointRecepieDetails
        
        from.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}
