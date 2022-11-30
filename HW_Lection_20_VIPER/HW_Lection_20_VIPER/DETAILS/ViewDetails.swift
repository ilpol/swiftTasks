//
//  View.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

import UIKit

protocol AnyViewDetails {
    var presenter: AnyPresenterDetails? {get set}
    
    func update(with name: String)
}

class DetailsViewController: UIViewController, AnyViewDetails{
    
    var presenter: AnyPresenterDetails?
    var fruits: [Fruit] = []
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = view.bounds
        
        label.center = view.center
    }
    
    func update(with name: String) {
        label.text = name
    }
}
