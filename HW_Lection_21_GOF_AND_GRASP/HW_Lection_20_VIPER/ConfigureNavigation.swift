//
//  ConfigureNavigation.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

protocol AnyConfigureNavigation {
    func openDetails(name: String)
}

class ConfigureNavigation: AnyConfigureNavigation {
    static let shared = ConfigureNavigation()
    var username: String?

    private init() { }
    
    func openDetails(name: String) {
        DetailsRouter.start(name: name)
    }
}
