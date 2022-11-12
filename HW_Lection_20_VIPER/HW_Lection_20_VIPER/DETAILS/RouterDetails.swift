//
//  Router.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

import UIKit

protocol AnyRouterDetails {
    static func start(name: String) -> Void
}

class DetailsRouter: AnyRouterDetails {

    static func start(name: String) {
        let router = DetailsRouter()
        
        var view: AnyViewDetails = DetailsViewController()
        var presenter: AnyPresenterDetails = DetailsPresenter()
        var interactor: AnyInteractorDetails = DetailsInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.onOpenDetails(name: name)
    }
}

