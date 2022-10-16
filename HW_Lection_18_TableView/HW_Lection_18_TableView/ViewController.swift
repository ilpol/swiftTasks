//
//  ViewController.swift
//  HW_Lection_18_TableView
//
//  Created by dfg on 16.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var fruitsBasket = FruitsStruct()
    
    var fruitsTableView = UITableView()
    var identifier = "FruitCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        fruitsTableView = UITableView(frame: view.bounds, style: .plain)
        fruitsTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: identifier)
        fruitsTableView.delegate = self
        fruitsTableView.dataSource = self
        
        view.addSubview(fruitsTableView)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.setTitle(titleName: fruitsBasket.fruitsNames[indexPath.row])
        detailViewController.setImage(imageName: fruitsBasket.fruitsImages[indexPath.row])
        present(detailViewController, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruitsBasket.fruitsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? DetailTableViewCell
        cell?.setLanguage(language: fruitsBasket.fruitsNames[indexPath.row])
        cell?.setIcon(iconName: fruitsBasket.fruitsImages[indexPath.row])
        
        return cell ?? DetailTableViewCell()
    }
}



