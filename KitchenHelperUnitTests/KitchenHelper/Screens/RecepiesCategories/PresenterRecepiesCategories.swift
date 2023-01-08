//
//  PresenterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

protocol AnyPresenterRecepiesCategories {
    var router: AnyRouterRecepiesCategories? {get set}
    var interactor: AnyInteractorRecepiesCategories? {get set}
    var view: AnyViewRecepiesCategories? {get set}
    func onLoadView()
    func onFetchedCategories(categories: [Category])
    func onSearch(querry: String)
    func onSeachResults(filteredCategories: [Category])
    func onImageLoaded(imageUrl: String, imageData: Data)
}

class PresenterRecepiesCategories: AnyPresenterRecepiesCategories {
        
    var router: AnyRouterRecepiesCategories?
    var interactor: AnyInteractorRecepiesCategories?

    var view: AnyViewRecepiesCategories?
    
    func onOpenFridge() {
    }
    
    func onLoadView() {
        interactor?.fetchRecepiesCategories()
    }
    
    func onFetchedCategories(categories: [Category]) {
        view?.loadCategories(categories: categories)
    }

    func onSearch(querry: String) {
        interactor?.onSearch(querry: querry)
    }
    
    func onSeachResults(filteredCategories: [Category]) {
        view?.onSeachResults(filteredCategories: filteredCategories)
    }
    
    func onImageLoaded(imageUrl: String, imageData: Data) {
        //view?.onImageLoaded(imageUrl: String, imageData: Data)
    }
}



