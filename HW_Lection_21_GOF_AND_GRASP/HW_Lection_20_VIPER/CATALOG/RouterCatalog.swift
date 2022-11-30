//
//  Router.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 11.11.2022.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func start() -> AnyRouter
    func onGoDetails(name: String)
}

class CatalogRouter: AnyRouter {
    var entry: EntryPoint?
    static func start() -> AnyRouter {
        let router = CatalogRouter()
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = FruitsPresenter()
        var interactor: AnyInteractor = FruitsInteractor()

        if (Constants.shared.isTest) {
            interactor = MockFruitsInteractor()
        }
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        
        return router
    }
    
    func onGoDetails(name: String) {
        ConfigureNavigation.shared.openDetails(name: name)
    }
}

