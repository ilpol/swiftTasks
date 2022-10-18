//
//  GreenVC.swift
//  HW_Lection_17
//
//  Created by dfg on 15.10.2022.
//

import UIKit

class GreenVC: UIViewController {

    @IBAction func onGreenToRed(_ sender: Any) {
        if let vc = RedVC.initFromSb() {
            navigationController?.pushViewController(vc, animated: true)
            // self.present(vc, animated: true)
        }
    }
    @IBAction func goToOrangeRootBySegue(_ sender: Any) {
        self.performSegue(withIdentifier: "goToOrangeRoot", sender: self)
    }
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
