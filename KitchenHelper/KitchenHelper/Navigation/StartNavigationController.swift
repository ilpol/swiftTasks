//
//  StartNavigationController.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit

class StartNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static var shared: UINavigationController?  = nil
    
    static func getNavController() -> UINavigationController {
        if (shared != nil) {
            return shared!
        } else {
            shared = StartNavigationController()
            return shared!
        }
    }
}
