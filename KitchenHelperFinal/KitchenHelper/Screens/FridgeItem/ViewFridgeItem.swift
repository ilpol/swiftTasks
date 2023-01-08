//
//  ViewFridgeItem.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit

protocol AnyViewFridgeItem {
    var presenter: AnyPresenterFridgeItem? {get set}
    func update(fridgeItem: FridgeItem)
}

class FridgeItemViewController: UIViewController, AnyViewFridgeItem {
    var presenter: AnyPresenterFridgeItem?
    var name = ""
    var itemDescription = ""
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let itemDescriptionLabel = UITextView()
    let viewWrapper = UIScrollView()
    private let itemImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()
    
    let wrapperMargin: CGFloat = 20
    
    func update(fridgeItem: FridgeItem) {
        nameLabel.text = fridgeItem.name
        let date = fridgeItem.overdueDate ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy hh:mm"
        let stringDate = formatter.string(from: date)
        dateLabel.text = stringDate
        itemDescriptionLabel.text = fridgeItem.itemDescription
        itemImage.image = UIImage(data: fridgeItem.image ?? Data()) ?? UIImage()
        itemImage.contentMode = .scaleAspectFit
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        viewWrapper.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(viewWrapper)
        viewWrapper.addSubview(nameLabel)
        viewWrapper.addSubview(dateLabel)
        viewWrapper.addSubview(itemDescriptionLabel)
        viewWrapper.addSubview(itemImage)
        
        nameLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        itemDescriptionLabel.textAlignment = .center
        itemDescriptionLabel.frame = CGRect(x: 20,y: 20,width: 200,height: 800)
        
        self.view.backgroundColor = .white
        
        itemDescriptionLabel.sizeToFit()
        
        itemDescriptionLabel.frame.size.width = 100
        itemDescriptionLabel.sizeToFit()
        
        nameLabel.font = nameLabel.font.withSize(30)
        itemDescriptionLabel.font = itemDescriptionLabel.font?.withSize(20)
        
        
        NSLayoutConstraint.activate([
            viewWrapper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: wrapperMargin),
            viewWrapper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -wrapperMargin),

            viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            viewWrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
       ])
        
        
        NSLayoutConstraint.activate([
            itemImage.heightAnchor.constraint(equalToConstant: 300),
            itemImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
       ])

        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            nameLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 20),
       ])
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
       ])

        NSLayoutConstraint.activate([
            itemDescriptionLabel.heightAnchor.constraint(equalToConstant: 200),
            itemDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            itemDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            itemDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
       ])

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewWrapper.contentSize = CGSize(width: 0, height: 2000)
    }
}
