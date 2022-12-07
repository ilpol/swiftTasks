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
        descriptionLabel.text = "4242"
        
        imageIcon.downloadFrom(from: imageUrl)
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

extension UIImageView {
    func downloadFrom(from imageString: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: imageString) else { return }
        contentMode = mode
        let savedImage = getItemByUrlUserDefaults(imageUrl: imageString)
        if (savedImage != nil) {
            self.image = UIImage(data: savedImage?.imageData ?? Data())
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }
                let image = UIImage(data: data)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.updateImageUserDefaults(imageUrl: imageString, imageData: data)
            }
            
        }.resume()
    }
    
    func updateImageUserDefaults(imageUrl: String, imageData: Data) {
        let defaults = UserDefaults.standard
        
        var imagesUserDefaults = getAllImageItemsUserDefaults()
        
        var isImageDataExist = false
        for imageUserDefaults in imagesUserDefaults {
            let str = (imageUserDefaults.imageUrlStr) as String

            if (str == imageUrl) {
                imageUserDefaults.imageData = imageData
                isImageDataExist = true
            }
        }
        
        if (!isImageDataExist) {
            
                let newImage = ImageEntity(imageUrlStrToSet: imageUrl, imageDataToSet: imageData)
                imagesUserDefaults.append(newImage)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(imagesUserDefaults) {
            defaults.set(encoded, forKey: "SavedImages")
        }
    }
    
    func getAllImageItemsUserDefaults() -> [ImageEntity] {

        let defaults = UserDefaults.standard
        if let savedImages = defaults.object(forKey: "SavedImages") as? Data {
            let decoder = JSONDecoder()
            if let loadedImages = try? decoder.decode(ImagesEntity.self, from: savedImages) {
                
                return loadedImages.images
            }
        }

        return []
    }
    
    func getItemByUrlUserDefaults(imageUrl: String) -> ImageEntity? {
        
        let imagesUserDefaults = getAllImageItemsUserDefaults()
        for imageUserDefaults in imagesUserDefaults {
            let savedStr = (imageUserDefaults.imageUrlStr) as String

            if (savedStr == imageUrl) {
                return imageUserDefaults
            }
        }
        
        return nil
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
