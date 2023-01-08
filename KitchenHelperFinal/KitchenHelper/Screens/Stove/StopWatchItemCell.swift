//
//  StopWatchItemCell.swift
//  KitchenHelper
//
//  Created by dfg on 13.11.2022.
//

import UIKit

class StopWatchItemCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var timerLabel = UILabel()
    var startStopButton = UIButton()
    var wrapView = UIView()
    var isTimerRunning = false
    var timer: Timer? = nil
    var totalSeconds = 0
    
    func setContent(titleToSet: String) {
        stopTimer()
        titleLabel.text = titleToSet
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(timerLabel)
        wrapView.addSubview(startStopButton)
        contentView.addSubview(wrapView)
        wrapView.backgroundColor = .clear
        startStopButton.backgroundColor = ColorsInstance.green
        
        startStopButton.layer.cornerRadius = 5
        startStopButton.layer.borderWidth = 1
        startStopButton.layer.borderColor = ColorsInstance.green.cgColor
        
        startStopButton.setTitle("Старт", for: .normal)
        
        startStopButton.setTitleColor(UIColor.black, for: .normal)
        
        startStopButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        
        wrapView.layer.borderColor = ColorsInstance.gray.cgColor
        wrapView.layer.borderWidth = 1.0
        wrapView.layer.cornerRadius = 10
        
        wrapView.layer.zPosition = 1;
        startStopButton.layer.zPosition = 2;
        
        timerLabel.text = "00:00"
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func toggleTimer() {
        if (isTimerRunning) {
            isTimerRunning = false
            timer?.invalidate()
            timer = nil
            startStopButton.setTitle("Старт", for: .normal)
        } else {
            isTimerRunning = true
            if (timer == nil) {
                timer = Timer(timeInterval: 1, target: self, selector: #selector(onTimerRunning(_:)), userInfo: nil, repeats: true)
                
                if (timer != nil) {
                    RunLoop.current.add(timer!, forMode: .common)
                }
            }
            startStopButton.setTitle("Стоп", for: .normal)
        }
    }
    
    @objc func onTimerRunning(_ timer: Timer) {
        totalSeconds += 1
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 3600) % 60
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        timerLabel.text = "\(minutesStr):\(secondsStr)"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 15))
        
        
        titleLabel.frame = CGRect(x: 25,
                                    y: 0,
                                    width: contentView.frame.width,
                                    height: contentView.frame.size.height/2
            )
       
        timerLabel.frame = CGRect(x: 55,
                                  y: 35,
                                  width: contentView.frame.width,
                                  height: contentView.frame.size.height/2
          )
        
        wrapView.frame = CGRect(x: 8,
                                y: 8,
                                    width: contentView.frame.width ,
                                height: contentView.frame.height
        )

        startStopButton.frame = CGRect(x: 15,
                                    y: 105,
                                        width: 130,
                                    height: 45
            )
    }
}

