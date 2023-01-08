//
//  ConfigureNavigation.swift
//  KitchenHelper
//
//  Created by dfg on 21.11.2022.
//

import UIKit

protocol AnyConfigureNavigation {
    func openFridgeItemForm(from view:UIViewController)
    func openFridgeItem(from view:UIViewController, fridgeItem: FridgeItem)
    func openRecepiesCategoriesContent(from view:UIViewController, categoryName: String)
    func openRecepiesDetails(from view:UIViewController, id: String)
    func openOnboarding(from prevView:UIViewController) 
}

class ConfigureNavigation: AnyConfigureNavigation {
    static let shared = ConfigureNavigation()
    var username: String?

    private init() { }
    
    func openFridgeItemForm(from view:UIViewController) {
        FridgeItemFormRouter.start(from: view)
    }
    func openFridgeItem(from view:UIViewController, fridgeItem: FridgeItem) {
        FridgeItemRouter.start(from: view, fridgeItem: fridgeItem)
    }
    func openRecepiesCategoriesContent(from view:UIViewController, categoryName: String) {
        RouterRecepiesCategoriesContent.start(from: view, categoryName: categoryName)
    }
    func openRecepiesDetails(from view:UIViewController, id: String) {
        RouterRecepieDetails.start(from: view, id: id)
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
