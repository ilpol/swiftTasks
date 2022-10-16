//
//  DetailViewController.swift
//  HW_Lection_18_TableView
//
//  Created by dfg on 16.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var titleLabel = UILabel()
    var image = UIImageView()
    
    let imageWidth: CGFloat = 80
    let imageHeigth: CGFloat = 80
    let spacing: CGFloat = 10
    
    override func viewDidLoad() {
       super.viewDidLoad()
       view?.backgroundColor = .white
        
       image.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
       image.widthAnchor.constraint(equalToConstant: imageHeigth).isActive = true

       titleLabel.textAlignment = .center

       let stackView = UIStackView()
       stackView.axis = NSLayoutConstraint.Axis.vertical
       stackView.distribution  = UIStackView.Distribution.equalSpacing
       stackView.alignment = UIStackView.Alignment.center
       stackView.spacing = spacing

       stackView.addArrangedSubview(image)
       stackView.addArrangedSubview(titleLabel)
       stackView.translatesAutoresizingMaskIntoConstraints = false
       
       view.addSubview(stackView)

       stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setTitle(titleName: String) {
        titleLabel.text = titleName
    }
    
    func setImage(imageName: String) {
        image.image = UIImage(named: imageName)
    }
    
}
