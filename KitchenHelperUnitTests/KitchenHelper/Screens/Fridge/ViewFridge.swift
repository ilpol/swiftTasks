//
//  ViewFridge.swift
//  KitchenHelper
//
//  Created by dfg on 20.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyViewFridge {
    var presenter: AnyPresenterFridge? {get set}
    
    func loadFridgeItems(fridgeItems: [FridgeItem])

}

class FridgeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, AnyViewFridge{
    
    var presenter: AnyPresenterFridge?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let tableView = UITableView()
    
    private var models = [FridgeItem]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        presenter?.onLoadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        
        tableView.register(FridgeItemCell.self, forCellReuseIdentifier: "FridgeItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        FridgeRouter.start(view: self)
        
        presenter?.onLoadView()
        
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
    }
    
    
    @objc func addNewItem() {
        presenter?.addNewItem()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count // recepies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FridgeItemCell", for: indexPath) as! FridgeItemCell
        let model = models[indexPath.row]
        //cell.recepieTitle.text = model.name
        let image = UIImage(data: model.image ?? Data()) ?? UIImage()
        cell.setContent(name: model.name ?? "", description: model.itemDescription ?? "", itemImage: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        
        let image = UIImage(data: model.image ?? Data()) ?? UIImage()
        
        presenter?.onItemClick(fridgeItem: model)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            presenter?.deleteItem(item: models[indexPath.row])
            
            models.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    func loadFridgeItems(fridgeItems: [FridgeItem]) {
        models = fridgeItems
        self.tableView.reloadData()
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
