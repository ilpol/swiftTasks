//
//  BlueVC.swift
//  HW_Lection_17
//
//  Created by dfg on 15.10.2022.
//

import UIKit

class BlueVC: UIViewController {

    @IBAction func goToPurpleRootByPop(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Appear blue")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Disappear blue")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("Destroy blue")
        }
    }
}
