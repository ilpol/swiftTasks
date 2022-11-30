//
//  StartNavigationController.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
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
