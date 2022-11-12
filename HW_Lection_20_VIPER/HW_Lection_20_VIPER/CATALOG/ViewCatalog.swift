//
//  View.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 11.11.2022.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with fruits: [Fruit])
    func update(with error: String)
    
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    var fruits: [Fruit] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(label)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        
        tableView.frame = view.bounds

        label.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        label.center = view.center
    }
    
    func update(with fruits: [Fruit]) {
        DispatchQueue.main.async {
            self.fruits = fruits
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func update(with error: String) {
        DispatchQueue.main.async {
            self.fruits = []
            self.tableView.isHidden = true
            self.label.text = error
            self.label.isHidden = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onSelectRow(name: fruits[indexPath.row].name)
    }
    
    
}


