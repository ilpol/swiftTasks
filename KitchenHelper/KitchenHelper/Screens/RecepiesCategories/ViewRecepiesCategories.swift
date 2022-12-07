//
//  ViewRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import UIKit

protocol AnyViewRecepiesCategories {
    func loadCategories(categories: [Category])
    var presenter: AnyPresenterRecepiesCategories? {get set}
    func onSeachResults(filteredCategories: [Category])
}

class RecepiesCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnyViewRecepiesCategories {

    let tableView = UITableView()
    var presenter: AnyPresenterRecepiesCategories?
    private var models = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "CategoryItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItems))
        
        
        let searchButton   = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItems))
        let clearButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearSearch))

        navigationItem.rightBarButtonItems = [clearButton, searchButton]
        
        RouterRecepiesCategories.start(view: self)
        presenter?.onLoadView()
       
    }
    func loadCategories(categories: [Category]) {
        models = categories
        print("loadCategories models = ", models)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count // recepies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath) as! CategoryItemCell
        cell.setContent(name: models[indexPath.row].name, description: models[indexPath.row].description, imageUrl: models[indexPath.row].imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .red

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
    
    @objc func searchItems() {
        let alertController = UIAlertController(title: "Поиск", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Например, Beef"
            }
        let saveAction = UIAlertAction(title: "Искать", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let querry = alertController.textFields![0] as UITextField
            self.presenter?.onSearch(querry: querry.text ?? "")
            })
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearSearch() {
        presenter?.onLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func onSeachResults(filteredCategories: [Category]) {
        models = filteredCategories
        self.tableView.reloadData()
    }
}


