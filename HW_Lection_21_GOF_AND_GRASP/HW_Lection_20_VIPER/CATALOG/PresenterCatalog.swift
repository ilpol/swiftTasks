//
//  Presenter.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 11.11.2022.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchFruits(with result: Result<[Fruit], Error>)
    
    func onSelectRow(name: String)
}

class FruitsPresenter: AnyPresenter {
    
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getFruits()
        }
    }
    var view: AnyView?
    
    func interactorDidFetchFruits(with result: Result<[Fruit], Error>) {
        switch result {
        case .success(let fruits):
            let collection = NamesCollection(with: fruits)
            // find name with max length
            var maxLength = -1
            var nameMaxLength = ""
            for curName in collection{
                if (curName.count > maxLength) {
                    nameMaxLength = curName
                    maxLength = curName.count
                }
            }
            
            view?.update(with: fruits, maxLength: maxLength, nameMaxLength: nameMaxLength)
            
        case .failure:
            view?.update(with: "Error fetching")
        }
    }
    
    func onSelectRow(name: String) {
        router?.onGoDetails(name: name)
    }
    
}

