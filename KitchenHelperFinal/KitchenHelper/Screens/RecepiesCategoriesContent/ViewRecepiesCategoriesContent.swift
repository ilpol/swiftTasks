//
//  ViewRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import UIKit

protocol AnyViewRecepiesCategoriesContent {
    func loadCategoryContent(categoryContent: [CategoryContent])
    var presenter: AnyPresenterRecepiesCategoriesContent? {get set}
    func onSeachResults(filteredCategories: [CategoryContent])
    func setCategoryName(name: String)
}

class RecepiesCategoriesContentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnyViewRecepiesCategoriesContent {
    
    let cellsPerRow = 2
    let margin: CGFloat = 20
    
    let refreshControl = UIRefreshControl()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemContentCell", for: indexPath) as! CategoryItemContentCell
        cell.setContent(name: models[indexPath.row].name, imageUrl: models[indexPath.row].imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 180, height: 200)
    }
    
    
    let categoriesContentCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryItemContentCell.self, forCellWithReuseIdentifier: "CategoryItemContentCell")
        return cv
    }()
    
    var categoryName = "" {
        didSet {
            presenter?.onLoadView(categoryName: categoryName)
        }
    }
    var presenter: AnyPresenterRecepiesCategoriesContent?
    var models = [CategoryContent]()
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
    
    func setCategoryName(name: String) {
        categoryName = name
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        isLoading = true
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
            presenter?.onLoadView(categoryName: self.categoryName)
        }
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryName
        
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        categoriesContentCollectionView.addSubview(refreshControl) // not required when using UITableViewController

        categoriesContentCollectionView.register(CategoryItemContentCell.self, forCellWithReuseIdentifier: "CategoryItemContentCell")
        categoriesContentCollectionView.dataSource = self
        categoriesContentCollectionView.delegate = self
        categoriesContentCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        view.addSubview(categoriesContentCollectionView)
        
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
        
        isLoading = true
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

    func loadCategoryContent(categoryContent: [CategoryContent]) {
        models = categoryContent
        self.categoriesContentCollectionView.reloadData()
        DispatchQueue.main.async(execute: categoriesContentCollectionView.reloadData)
        isLoading = false
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curModel = models[indexPath.row]
        presenter?.onSelectItem(id: curModel.id)
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

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoriesContentCollectionView.frame = view.bounds
    }
    
    func onSeachResults(filteredCategories: [CategoryContent]) {
        models = filteredCategories
        self.categoriesContentCollectionView.reloadData()
        isLoading = false
    }
}
