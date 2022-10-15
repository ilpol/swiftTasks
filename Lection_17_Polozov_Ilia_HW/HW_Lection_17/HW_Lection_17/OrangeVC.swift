//
//  OrangeController.swift
//  HW_Lection_17
//
//  Created by dfg on 15.10.2022.
//

import UIKit

class OrangeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onOrangeToGreen() {
        if let vc = GreenVC.initFromSb() {
            navigationController?.pushViewController(vc, animated: true)
            // self.present(vc, animated: true)
        }
        
        /* let vc = UIViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Appear orange")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Disappear orange")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("Destroy orange")
        }
    }
    
}

