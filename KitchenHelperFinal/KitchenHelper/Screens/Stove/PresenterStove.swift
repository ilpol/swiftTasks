//
//  PresenterStove.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit

protocol AnyPresenterStove {
    var router: AnyRouterStove? {get set}
    var interactor: AnyInteractorStove? {get set}
    var view: AnyViewStove? {get set}
}

class StovePresenter: AnyPresenterStove {
        
    var router: AnyRouterStove?
    var interactor: AnyInteractorStove?

    var view: AnyViewStove?
    
    func addNewItem() {
        router?.toItemForm()
    }
}
