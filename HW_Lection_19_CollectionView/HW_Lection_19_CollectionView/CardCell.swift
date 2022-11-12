//
//  CardCell.swift
//  HW_Lection_19_CollectionView
//
//  Created by dfg on 30.10.2022.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    func setup(width card: Card){
        cardImage.image = card.image
        cardTitle.text = card.title
    }
}
