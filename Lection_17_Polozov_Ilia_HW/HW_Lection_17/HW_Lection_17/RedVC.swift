//
//  RedVC.swift
//  HW_Lection_17
//
//  Created by dfg on 18.10.2022.
//

import UIKit

class RedVC: UIViewController {

    @IBAction func goToOrangeRootBySegue(_ sender: Any) {
        self.performSegue(withIdentifier: "goToOrangeRoot", sender: self)
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


