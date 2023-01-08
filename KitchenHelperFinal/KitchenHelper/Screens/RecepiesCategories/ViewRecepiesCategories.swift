//
//  ViewRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyViewRecepiesCategories {
    func loadCategories(categories: [Category])
    var presenter: AnyPresenterRecepiesCategories? {get set}
    func onSeachResults(filteredCategories: [Category])
}

class RecepiesCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnyViewRecepiesCategories {

    let tableView = UITableView()
    var presenter: AnyPresenterRecepiesCategories?
    var models = [Category]()
    var isLoading = false {
        didSet {
            if (isLoading) {
                loaderAnimate(isRunning: true)
            } else {
                loaderAnimate(isRunning: false)
            }
        }
    }
    let frameLoaderIcon = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    var loaderIcon = UIView()
    let loaderAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    let refreshControl = UIRefreshControl()

    @objc func refresh(_ sender: AnyObject) {
        isLoading = true
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.presenter?.onLoadView()
        }
        refreshControl.endRefreshing()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "CategoryItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(tableView)
        
        loaderIcon = UIView(frame: frameLoaderIcon)
        
        loaderIcon.backgroundColor = .black
        view.addSubview(loaderIcon)
        
        loaderIcon.center = CGPoint(x: view.frame.size.width  / 2,
                                     y: view.frame.size.height / 2)
        
        loaderIcon.isHidden = true
        
        loaderAnimation.duration = 3
        loaderAnimation.toValue = 20
        loaderAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        loaderIcon.layer.add(loaderAnimation, forKey: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItems))
        
        
        let searchButton   = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItems))

        navigationItem.rightBarButtonItems = [/*clearButton, */searchButton]
        
        RouterRecepiesCategories.start(view: self)
        isLoading = true
        presenter?.onLoadView()
       
    }
    
    func loaderAnimate (isRunning: Bool) {
        if (isRunning) {
            loaderIcon.isHidden = false
            loaderIcon.layer.add(loaderAnimation, forKey: nil)
        } else {
            loaderIcon.isHidden = true
            loaderIcon.layer.removeAllAnimations()
        }
    }
    func loadCategories(categories: [Category]) {
        models = categories
        self.tableView.reloadData()
        isLoading = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count // recepies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath) as! CategoryItemCell
        cell.selectionStyle = .none
        cell.setContent(name: models[indexPath.row].name, description: models[indexPath.row].description, imageUrl: models[indexPath.row].imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curModel = models[indexPath.row]
        presenter?.onSelectCategory(categoryName: curModel.name)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280;
    }
    
    @objc func searchItems() {
        isLoading = true
        let alertController = UIAlertController(title: "Поиск", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Например, Beef"
            }
        let saveAction = UIAlertAction(title: "Искать", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let querry = alertController.textFields![0] as UITextField
            self.presenter?.onSearch(querry: querry.text ?? "")
            })
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in
            self.isLoading = false
        })
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearSearch() {
        isLoading = true
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.presenter?.onLoadView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func onSeachResults(filteredCategories: [Category]) {
        models = filteredCategories
        self.tableView.reloadData()
        isLoading = false
    }
}

