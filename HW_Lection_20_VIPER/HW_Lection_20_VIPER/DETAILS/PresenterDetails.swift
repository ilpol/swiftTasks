//
//  Presenter.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

import Foundation
import UIKit

protocol AnyPresenterDetails {
    var router: AnyRouterDetails? {get set}
    var interactor: AnyInteractorDetails? {get set}
    var view: AnyViewDetails? {get set}

    func onOpenDetails(name: String)
}

class DetailsPresenter: AnyPresenterDetails {
        
    var router: AnyRouterDetails?
    var interactor: AnyInteractorDetails?
    var view: AnyViewDetails?
    
    func onOpenDetails(name: String) {
        view?.update(with: name)
        StartNavigationController.getNavController().pushViewController(view! as! UIViewController, animated: true)
        
    }
    
}
