//
//  CategoryItemCell.swift
//  KitchenHelper
//
//  Created by dfg on 16.11.2022.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var wrapView = UIView()
    var nameWidth: CGFloat = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let myImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()
    
    private let imageIcon: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        image.contentMode = .center
        image.clipsToBounds = false
        return image
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     addSubview(titleLabel)
     addSubview(imageIcon)
     addSubview(wrapView)
        
        wrapView.layer.borderColor = ColorsInstance.green.cgColor
        wrapView.layer.borderWidth = 1.0
        wrapView.layer.cornerRadius = 10
        
        titleLabel.font = titleLabel.font.withSize(20)
    }
    func setContent(name: String, description: String, imageUrl: String) {
        titleLabel.text = name
        nameWidth = name.width(withConstrainedHeight: 5, font: UIFont(name: titleLabel.font.fontName, size: 20)!)
        imageIcon.downloadFrom(from: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
        titleLabel.frame = CGRect(x: contentView.frame.width / 2 - (nameWidth / 2),
                                    y: 220,
                                    width: contentView.frame.width,
                                    height: 40
            )
        
        imageIcon.frame = CGRect(x: contentView.frame.width / 2 - (150 / 2),
                                    y: 50,
                                        width: 140,
                                    height: 140
            )
        wrapView.frame = CGRect(x: 8,
                                y: 8,
                                    width: contentView.frame.width ,
                                height: 260
        )
    }
}
