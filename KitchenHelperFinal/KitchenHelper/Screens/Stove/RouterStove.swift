//
//  RouterStove.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit

typealias EntryPointStove = AnyViewFridge & UIViewController

protocol AnyRouterStove {
    static func start(view: StoveViewController) -> Void
    var entry: EntryPointStove? {get}
    func toItemForm()
}

class StoveRouter: AnyRouterStove {
    
    var entry: EntryPointFridge?
    
    func toItemForm() {
    }

    static func start(view: StoveViewController)-> Void {
        let router = StoveRouter()
        
        var presenter: AnyPresenterStove = StovePresenter()
        var interactor: AnyInteractorStove = StoveInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        
        router.entry = view as? EntryPointStove
    }
}
