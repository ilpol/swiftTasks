//
//  ViewStove.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit
import AVFoundation

protocol AnyViewStove {
    var presenter: AnyPresenterStove? {get set}
}

enum timerState {
    case timer
    case stopWatch
}

class StoveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnyViewStove {
    
    var presenter: AnyPresenterStove?
    
    let margin: CGFloat = 20
    let cellsPerRow = 2
    var timerOrStopWatch = timerState.stopWatch
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let titleToSet = timerOrStopWatch == timerState.stopWatch ? "Секундомер \(indexPath[1])" : "Таймер \(indexPath[1])"
        
        if (timerOrStopWatch == timerState.stopWatch) {
            
            let cellStopWatch = collectionView.dequeueReusableCell(withReuseIdentifier: "StopWatchCell", for: indexPath) as! StopWatchItemCell
            cellStopWatch.setContent(titleToSet: titleToSet)
            return cellStopWatch
        }
        
        let cellTimer = collectionView.dequeueReusableCell(withReuseIdentifier: "TimerItemCell", for: indexPath) as! TimerItemCell
        
        
        cellTimer.setContent(titleToSet: titleToSet, viewController: self)
        return cellTimer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 176, height: 176)
    }
    
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(StopWatchItemCell.self, forCellWithReuseIdentifier: "StopWatchCell")
        cv.register(TimerItemCell.self, forCellWithReuseIdentifier: "TimerItemCell")
        return cv
    }()

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    private let changeStopWatchButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//        button.layer.cornerRadius = 10
//        button.backgroundColor = .systemPink
//        button.tintColor = .white
//        button.setTitleColor(.white, for: .normal)
//        button.layer.shadowRadius = 10
//        button.layer.shadowOpacity = 0.3
//        return button
//    }()
    
    
    @objc func changeTimer() {
        if (timerOrStopWatch == timerState.timer) {
            timerOrStopWatch = timerState.stopWatch
        } else {
            timerOrStopWatch = timerState.timer
        }
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // changeStopWatchButton.setTitle("Таймер", for: .normal)
        
        // changeStopWatchButton.addTarget(self, action: #selector(changeTimer), for: .touchUpInside)

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeTimer))

        
        collectionView.register(StopWatchItemCell.self, forCellWithReuseIdentifier: "StopWatchCell")
        collectionView.register(TimerItemCell.self, forCellWithReuseIdentifier: "TimerItemCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        view.addSubview(collectionView)
        // view.addSubview(changeStopWatchButton)
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        

        StoveRouter.start(view: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
//        changeStopWatchButton.frame = CGRect(
//            x: view.frame.size.width - 120,
//            y: view.frame.size.height - 130,
//            width: 100,
//            height: 40
//        )
    }

}
