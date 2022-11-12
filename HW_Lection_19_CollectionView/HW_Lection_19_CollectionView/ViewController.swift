//
//  ViewController.swift
//  HW_Lection_19_CollectionView
//
//  Created by dfg on 30.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let adapter = CardAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CardCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

