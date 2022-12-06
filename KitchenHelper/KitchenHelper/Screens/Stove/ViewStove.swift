//
//  ViewStove.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyViewStove {
    var presenter: AnyPresenterStove? {get set}
}

class StoveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnyViewStove {
    
    var presenter: AnyPresenterStove?
    
    let margin: CGFloat = 20
    let cellsPerRow = 2
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StopWatchCell", for: indexPath) as! StopWatchItemCell
        cell.setContent(titleToSet: "Таймер \(indexPath[1])")
        cell.startStopButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth = ((collectionView.bounds.size.width - margin) / CGFloat(cellsPerRow)).rounded(.down)
    
        return CGSize(width: 176, height: 176)
    }
    
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(StopWatchItemCell.self, forCellWithReuseIdentifier: "StopWatchCell")
        return cv
    }()
    
    var timer1: Timer? = nil
    var totalSeconds1 = 0
    var isRunning1 = false
    
    var timer2: Timer? = nil
    var totalSeconds2 = 0
    var isRunning2 = false
    
    var timer3: Timer? = nil
    var totalSeconds3 = 0
    var isRunning3 = false
    
    var timer4: Timer? = nil
    var totalSeconds4 = 0
    var isRunning4 = false
    
    var timer5: Timer? = nil
    var totalSeconds5 = 0
    var isRunning5 = false
    
    var timer6: Timer? = nil
    var totalSeconds6 = 0
    var isRunning6 = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        timers = [timer1, timer2, timer3, timer4, timer5, timer6]
        timersTotalSeconds = [totalSeconds1, totalSeconds2, totalSeconds3, totalSeconds4, totalSeconds5, totalSeconds6]
        timersIsRunning = [isRunning1, isRunning2, isRunning3, isRunning4, isRunning5, isRunning6]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var timers: [Timer?]  = []
    
    var timersTotalSeconds: [Int] = []
    
    var timersIsRunning: [Bool] = []
    
    var stopWatchTimeLabels: [UILabel] = []
    var stopWatchButtons: [UIButton] = []
    
    func startTimer(timerNumber: Int) {
        timersIsRunning[timerNumber] = true
        if (timers[timerNumber] == nil) {
            timers[timerNumber] = Timer(timeInterval: 1, target: self, selector: #selector(onTimerRunning(_:)), userInfo: timerNumber, repeats: true)
            
            if (timers[timerNumber] != nil) {
                RunLoop.current.add(timers[timerNumber]!, forMode: .common)
            }
        }
    }
    
    func stopTimer(timerNumber: Int) {
        timersIsRunning[timerNumber] = false
        timers[timerNumber]?.invalidate()
        timers[timerNumber] = nil
    }
    
    @objc func onTimerRunning(_ timer: Timer) {
        guard let timerNumber = timer.userInfo as? Int else { return }
        timersTotalSeconds[timerNumber] += 1
        let minutes = (timersTotalSeconds[timerNumber] % 3600) / 60
        let seconds = (timersTotalSeconds[timerNumber] % 3600) % 60
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StopWatchCell", for: IndexPath(row: timerNumber, section: 0)) as! StopWatchItemCell
        cell.timerLabel.text = "\(minutesStr):\(secondsStr)"
    }
    
    @objc func toggleTimer(timerNumber: Int) {
        if (timersIsRunning[timerNumber]) {
            stopTimer(timerNumber: timerNumber)
            stopWatchButtons[timerNumber].setTitle("Старт", for: .normal)
        } else {
            startTimer(timerNumber: timerNumber)
            stopWatchButtons[timerNumber].setTitle("Стоп", for: .normal)
        }
    }
    
    let stopWatch1TimeLabel = UILabel()
    let stopWatch2TimeLabel = UILabel()
    let stopWatch3TimeLabel = UILabel()
    let stopWatch4TimeLabel = UILabel()
    let stopWatch5TimeLabel = UILabel()
    let stopWatch6TimeLabel = UILabel()

    let stopWatch1Button = UIButton()
    let stopWatch2Button = UIButton()
    let stopWatch3Button = UIButton()
    let stopWatch4Button = UIButton()
    let stopWatch5Button = UIButton()
    let stopWatch6Button = UIButton()
    
    let stopWatch1Wrap = UIView()
    let stopWatch2Wrap = UIView()
    let stopWatch3Wrap = UIView()
    let stopWatch4Wrap = UIView()
    let stopWatch5Wrap = UIView()
    let stopWatch6Wrap = UIView()
    
    
//    @IBAction func stopWatch1OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 0)
//    }
//    @IBAction func stopWatch2OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 1)
//    }
//    @IBAction func stopWatch3OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 2)
//    }
//    @IBAction func stopWatch4OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 3)
//    }
//    @IBAction func stopWatch5OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 4)
//    }
//    @IBAction func stopWatch6OnToggle(_ sender: Any) {
//        toggleTimer(timerNumber: 5)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(StopWatchItemCell.self, forCellWithReuseIdentifier: "StopWatchCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        stopWatchTimeLabels = [stopWatch1TimeLabel, stopWatch2TimeLabel, stopWatch3TimeLabel, stopWatch4TimeLabel, stopWatch5TimeLabel, stopWatch6TimeLabel]
        stopWatchButtons = [stopWatch1Button, stopWatch2Button, stopWatch3Button, stopWatch4Button, stopWatch5Button, stopWatch6Button]

        StoveRouter.start(view: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
    }

}
