//
//  DetailTableViewCell.swift
//  HW_Lection_18_TableView
//
//  Created by dfg on 16.10.2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var title = UILabel()
    var icon = UIImageView()

    let leftMargin: CGFloat = 15
    let scacing: CGFloat = 10
    let iconWidth: CGFloat = 30
    let iconHeight: CGFloat = 30
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon.heightAnchor.constraint(equalToConstant: iconWidth).isActive = true
        icon.widthAnchor.constraint(equalToConstant: iconHeight).isActive = true
        
        title.textAlignment = .center

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = scacing

        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(title)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)

        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftMargin).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLanguage(language: String) {
        title.text = language
    }
    
    func setIcon(iconName: String) {
        icon.image = UIImage(named: iconName)
    }

}
