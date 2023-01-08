//
//  Extentions.swift
//  KitchenHelper
//
//  Created by dfg on 08.01.2023.
//

import Foundation
import UIKit

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}


extension UIImageView {
    func downloadFrom(from imageString: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: imageString) else { return }
        let savedImage = getItemByUrlCoreData(imageUrl: imageString)
        self.image = UIImage(data: savedImage.imageData ?? Data())
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }
                let image = UIImage(data: data)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.updateImageCoreData(imageUrl: imageString, imageData: data)
            }
            
        }.resume()
    }
    
    func updateImageCoreData(imageUrl: String, imageData: Data) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let imageCoreData = getItemByUrlCoreData(imageUrl: imageUrl)
        imageCoreData.imageData = imageData
        do {
            try context.save()
        }
        catch {
            print("error updating image on CoreData")
        }
    }
    
    func getAllImageItemsCoreData() -> [DownloadedImage] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          let savedImages = try context.fetch(DownloadedImage.fetchRequest())
            return savedImages
        }
        catch {
            print("error getting all images from CoreData")
        }
        return []
    }
    
    func getItemByUrlCoreData(imageUrl: String) -> DownloadedImage {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          let imagesCoreData = getAllImageItemsCoreData()
            for imageCoreData in imagesCoreData {
                let str = (imageCoreData.imageUrlStr ?? "") as String

                if (str == imageUrl) {
                    return imageCoreData
                }
            }
            let newItem = DownloadedImage(context: context)
            newItem.imageUrlStr = imageUrl
            newItem.imageData = Data()
            return newItem
        }
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


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



extension UIView{
     func blink() {
         self.alpha = 0.2
         UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
     }
}
