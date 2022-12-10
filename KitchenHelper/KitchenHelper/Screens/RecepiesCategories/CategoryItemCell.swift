//
//  CategoryItemCell.swift
//  KitchenHelper
//
//  Created by dfg on 16.11.2022.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var wrapView = UIView()
    var nameWidth: CGFloat = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let myImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        return image
    }()
    
    private var imageIcon: UIImageView = { () -> UIImageView in
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
    func setContent(name: String, description: String, imageUrl: String) {
        titleLabel.text = name
        nameWidth = name.width(withConstrainedHeight: 5, font: UIFont(name: titleLabel.font.fontName, size: 20)!)
        
        NetworService.shared.fetchImage(imageUrl: imageUrl) { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories, \(error)")
            case .success(let response):
                self.imageIcon.image = UIImage(data: response)!
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
        titleLabel.frame = CGRect(x: contentView.frame.width / 2 - (nameWidth / 2),
                                    y: 150 + 5,
                                    width: contentView.frame.width,
                                    height: 40
            )
        
        imageIcon.frame = CGRect(x: contentView.frame.width / 2 - (150 / 2),
                                    y: 5,
                                        width: 150,
                                    height: 150
            )
        wrapView.frame = CGRect(x: 8,
                                y: 8,
                                    width: contentView.frame.width ,
                                height: 190
        )
        
    }
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
