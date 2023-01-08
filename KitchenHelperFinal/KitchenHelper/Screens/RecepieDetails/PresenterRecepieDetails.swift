//
//  PresenterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

protocol AnyPresenterRecepieDetails {
    var router: AnyRouterRecepieDetails? {get set}
    var interactor: AnyInteractorRecepieDetails? {get set}
    var view: AnyViewRecepieDetails? {get set}
    func onLoadView(id: String)
    func onFetchedRecepieDetails(recepieDetails: [RecepieDetails])
}

class PresenterRecepieDetails: AnyPresenterRecepieDetails {
        
    var router: AnyRouterRecepieDetails?
    var interactor: AnyInteractorRecepieDetails?

    var view: AnyViewRecepieDetails?
    
    func onOpenFridge() {
    }
    
    func onLoadView(id: String) {
        interactor?.fetchRecepieDetails(id: id)
    }
    
    func onFetchedRecepieDetails(recepieDetails: [RecepieDetails]) {
        view?.loadRecepieDetails(recepieDetails: recepieDetails)
    }

}



