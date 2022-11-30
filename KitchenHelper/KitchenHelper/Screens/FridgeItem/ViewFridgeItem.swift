//
//  ViewFridgeItem.swift
//  KitchenHelper
//
//  Created by dfg on 26.11.2022.
//

import UIKit

protocol AnyViewFridgeItem {
    //func loadCategories(categories: [Category])
    var presenter: AnyPresenterFridgeItem? {get set}
    
    
    func update(fridgeItem: FridgeItem)
}

class FridgeItemViewController: UIViewController, AnyViewFridgeItem {
    var presenter: AnyPresenterFridgeItem?
    var name = ""
    var itemDescription = ""
    let nameLabel = UILabel()
    let itemDescriptionLabel = UITextView()
    private let itemImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()
    
    func setContent(name: String, description: String, image: UIImage) {
        nameLabel.text = name
        itemDescriptionLabel.text = "fdsfds fd f dsf ds fds f sd f sf dsf ds f sf sd fds f sf df sdf f ds fds f sdf sd f df sd  fdsf  4234 24 32 4 23"
        itemImage.image = image
        itemImage.contentMode = .scaleAspectFit
        
    }
    
    func update(fridgeItem: FridgeItem) {
        nameLabel.text = fridgeItem.name
        itemDescriptionLabel.text = fridgeItem.itemDescription
        itemImage.image = UIImage(data: fridgeItem.image ?? Data()) ?? UIImage()
        itemImage.contentMode = .scaleAspectFit
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(nameLabel)
        view.addSubview(itemDescriptionLabel)
        view.addSubview(itemImage)
        
        nameLabel.textAlignment = .center
        itemDescriptionLabel.textAlignment = .center
        itemDescriptionLabel.frame = CGRect(x: 20,y: 20,width: 200,height: 800)
        
        itemDescriptionLabel.sizeToFit()
        
        itemDescriptionLabel.frame.size.width = 100
        itemDescriptionLabel.sizeToFit()
        
        
        NSLayoutConstraint.activate([
            itemImage.heightAnchor.constraint(equalToConstant: 200),
            itemImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
       ])
        
        nameLabel.backgroundColor = .systemPink
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            nameLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor),
       ])
        
        itemDescriptionLabel.backgroundColor = .brown
        NSLayoutConstraint.activate([
            itemDescriptionLabel.heightAnchor.constraint(equalToConstant: 200),
            itemDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1),
            itemDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            itemDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
       ])
        
    }

}
