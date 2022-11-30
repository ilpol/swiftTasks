//
//  RouterFridgeItemForm.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit

protocol AnyRouterFridgeItemForm {
    static func start(from prevView: UIViewController) -> AnyRouterFridgeItemForm
    var entry: EntryPointFridgeItemForm? {get}
}

typealias EntryPointFridgeItemForm = AnyViewFridgeItemForm & UIViewController

class FridgeItemFormRouter: AnyRouterFridgeItemForm {
    
    
    var entry: EntryPointFridgeItemForm?

    static func start(from prevView: UIViewController)-> AnyRouterFridgeItemForm {
        let router = FridgeItemFormRouter()
        
        var view: AnyViewFridgeItemForm = FridgeItemFormViewController()
        var presenter: AnyPresenterFridgeItemForm = FridgeItemFormPresenter()
        var interactor: AnyInteractorFridgeItemForm = FridgeItemFormInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.onOpenFridge()
        
        router.entry = view as? EntryPointFridgeItemForm
        
        prevView.navigationController?.pushViewController(view as! UIViewController, animated: true)
        
        return router
    }
}



