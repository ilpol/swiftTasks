//
//  PresenterRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 25.11.2022.
//

import UIKit

protocol AnyPresenterRecepiesCategoriesContent {
    var router: AnyRouterRecepiesCategoriesContent? {get set}
    var interactor: AnyInteractorRecepiesCategoriesContent? {get set}
    var view: AnyViewRecepiesCategoriesContent? {get set}
    func onLoadView(categoryName: String)
    func onFetchedCategoryContent(categoryContent: [CategoryContent])
    func onSelectItem(id: String)
    func onSearch(querry: String)
    func onSeachResults(filteredCategories: [CategoryContent])
}

class PresenterRecepiesCategoriesContent: AnyPresenterRecepiesCategoriesContent {
        
    var router: AnyRouterRecepiesCategoriesContent?
    var interactor: AnyInteractorRecepiesCategoriesContent?

    var view: AnyViewRecepiesCategoriesContent?
    
    func onLoadView(categoryName: String) {
        interactor?.fetchRecepiesCategoryContent(categoryName: categoryName)
    }
    
    func onFetchedCategoryContent(categoryContent: [CategoryContent]) {
        view?.loadCategoryContent(categoryContent: categoryContent)
    }

    func onSearch(querry: String) {
        interactor?.onSearch(querry: querry)
    }
    
    func onSeachResults(filteredCategories: [CategoryContent]) {
        view?.onSeachResults(filteredCategories: filteredCategories)
    }

    func onSelectItem(id: String) {
        router?.toRecepiesDetailsScreen(id: id)
    }
}
