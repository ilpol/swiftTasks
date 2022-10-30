//
//  CardAdapter.swift
//  HW_Lection_19_CollectionView
//
//  Created by dfg on 30.10.2022.
//

import UIKit

class CardAdapter: NSObject {
    let margin: CGFloat = 20
    let cellsPerRow = 2
    
}

extension CardAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.setup(width: cards[indexPath.row])
        return cell
    }
}

extension CardAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = ((collectionView.bounds.size.width - margin) / CGFloat(cellsPerRow)).rounded(.down)
    
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}
