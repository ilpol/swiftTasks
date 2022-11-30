//
//  RecepieCell.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import UIKit

class FridgeItemCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var wrapView = UIView()
    
    private let myImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()
    
    private let imageIcon: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     addSubview(titleLabel)
     addSubview(descriptionLabel)
     addSubview(imageIcon)
     addSubview(wrapView)
        
        wrapView.layer.borderColor = ColorsInstance.green.cgColor
        wrapView.layer.borderWidth = 1.0
        wrapView.layer.cornerRadius = 10
        
        imageIcon.layer.borderWidth = 1
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.borderColor = UIColor.clear.cgColor
        imageIcon.layer.cornerRadius = imageIcon.frame.height/2
        imageIcon.clipsToBounds = true
        imageIcon.layer.cornerRadius = 10
    }

    func setContent(name: String, description: String, itemImage: UIImage) {
        titleLabel.text = name
        descriptionLabel.text = description
        imageIcon.image = itemImage
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
        titleLabel.frame = CGRect(x: 140,
                                    y: 5,
                                    width: contentView.frame.width,
                                    height: contentView.frame.size.height/2
            )
        descriptionLabel.frame = CGRect(x: 140,
                                    y: 30,
                                        width: contentView.frame.width,
                                    height: contentView.frame.size.height/2
            )
        
        
        imageIcon.frame = CGRect(x: 20,
                                    y: 23,
                                        width: 100,
                                    height: 100
            )
        wrapView.frame = CGRect(x: 8,
                                y: 8,
                                    width: contentView.frame.width ,
                                height: contentView.frame.height
        )
        
    }
    
}
