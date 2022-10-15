//
//  GreenVC.swift
//  HW_Lection_17
//
//  Created by dfg on 15.10.2022.
//

import UIKit

class GreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Appear green")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Disappear green")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("Destroy green")
        }
    }

}
