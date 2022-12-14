//
//  Interactor.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

import Foundation

protocol AnyInteractorDetails {
    var presenter: AnyPresenterDetails? {get set}
}

class DetailsInteractor: AnyInteractorDetails {
    var presenter: AnyPresenterDetails?
}
