//
//  ConfigureNavigation.swift
//  KitchenHelper
//
//  Created by dfg on 21.11.2022.
//

import UIKit

protocol AnyConfigureNavigation {
    func openDetails(name: String)
    func openFridgeItemForm(from view:UIViewController)
}

class ConfigureNavigation: AnyConfigureNavigation {
    static let shared = ConfigureNavigation()
    var username: String?

    private init() { }
    
    func openDetails(name: String) {
        //DetailsRouter.start(name: name)
    }
    func openFridgeItemForm(from view:UIViewController) {
        FridgeItemFormRouter.start(from: view)
    }
    func openFridgeItem(from view:UIViewController, fridgeItem: FridgeItem) {
        FridgeItemRouter.start(from: view, fridgeItem: fridgeItem)
    }
    func openOnboarding(from prevView:UIViewController) {
        let defaults = UserDefaults.standard
        let isShownOnboarding = defaults.bool(forKey: "isShownOnboarding")
        if (!isShownOnboarding) {
            defaults.set(true, forKey: "isShownOnboarding")
            let viewOnboarding = ViewOnboarding()
            viewOnboarding.modalPresentationStyle = .overFullScreen
            
            prevView.navigationController?.pushViewController(viewOnboarding as UIViewController, animated: true)
        }
        
    }
}
