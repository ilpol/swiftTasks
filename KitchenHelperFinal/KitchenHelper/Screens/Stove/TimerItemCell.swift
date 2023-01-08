//
//  StopWatchItemCell.swift
//  KitchenHelper
//
//  Created by dfg on 13.11.2022.
//

import UIKit
import AVFoundation
import Foundation

class TimerItemCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var timerLabel = UILabel()
    var startStopButton = UIButton()
    var settingButton = UIButton()
    var isSound = false
    var wrapView = UIView()
    var isTimerRunning = false
    var timer: Timer? = nil
    var totalSeconds = 2
    var timerOrStopWatch = timerState.timer
    var parentViewController = UIViewController()
    
    func setContent(titleToSet: String, viewController: UIViewController) {
        parentViewController = viewController
        stopTimer()
        titleLabel.text = titleToSet
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(timerLabel)
        wrapView.addSubview(startStopButton)
        wrapView.addSubview(settingButton)
        contentView.addSubview(wrapView)
        wrapView.backgroundColor = .clear
        startStopButton.backgroundColor = ColorsInstance.green
        settingButton.backgroundColor = ColorsInstance.gray
        
        startStopButton.layer.cornerRadius = 5
        startStopButton.layer.borderWidth = 1
        startStopButton.layer.borderColor = ColorsInstance.green.cgColor
        
        settingButton.layer.cornerRadius = 5
        settingButton.layer.borderWidth = 1
        settingButton.layer.borderColor = ColorsInstance.gray.cgColor
        
        startStopButton.setTitle("Пуск", for: .normal)
        settingButton.setTitle("Изменить", for: .normal)
        
        startStopButton.setTitleColor(UIColor.black, for: .normal)
        
        startStopButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        
        settingButton.addTarget(self, action: #selector(changeTime), for: .touchUpInside)
        
        wrapView.layer.borderColor = ColorsInstance.gray.cgColor
        wrapView.layer.borderWidth = 1.0
        wrapView.layer.cornerRadius = 10
        
        wrapView.layer.zPosition = 1;
        startStopButton.layer.zPosition = 2;
        
        timerLabel.text = "00:02"
    }
    
    let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    @objc func changeTime() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        pickerView.datePickerMode = .countDownTimer
        pickerView.addTarget(self, action: #selector(onTimerSet(sender:)), for: UIControl.Event.valueChanged)
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Выбор времени", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Задать", style: .default, handler: nil))
        parentViewController.present(editRadiusAlert, animated: true)
        
    }
    
    @objc func onTimerSet(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        totalSeconds = Int(pickerView.countDownDuration)
        let minutesToDisplay = Int(floor(Double(totalSeconds / 60)));
        let secondsToDisplay = totalSeconds - Int(minutesToDisplay) * 60;
        let minutesToDisplayStr = minutesToDisplay < 10 ? "0\(minutesToDisplay)" : "\(minutesToDisplay)"
        let secondsToDisplayStr = secondsToDisplay < 10 ? "0\(secondsToDisplay)" : "\(secondsToDisplay)"
        timerLabel.text = "\(minutesToDisplayStr):\(secondsToDisplayStr)"
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
        if (totalSeconds == 0) {
            stopReminding()
            initTimer()
        }
    }

    func initTimer() {
        totalSeconds = 60
        startStopButton.setTitle("Старт", for: .normal)
        timerLabel.text = "01:00"
        stopReminding()
    }
    
    @objc func onTimerRunning(_ timer: Timer) {
        if (totalSeconds != 0) {
            totalSeconds -= 1
            let minutes = (totalSeconds % 3600) / 60
            let seconds = (totalSeconds % 3600) % 60
            let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            timerLabel.text = "\(minutesStr):\(secondsStr)"
        } else {
            stopTimer()
            remindUser()
            
        }
    }
    
    func startSound() {
        if (isSound) {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                AudioServicesPlaySystemSound(1026)
                self.startSound()
            }
        }
    }
    
    func remindUser() {
        timerLabel.textColor = .red
        timerLabel.blink()
        titleLabel.textColor = .red
        titleLabel.blink()
        isSound = true
        startSound()
    }
    func stopReminding() {
        timerLabel.layer.removeAllAnimations()
        timerLabel.layer.removeAllAnimations()
        timerLabel.layoutIfNeeded()
        timerLabel.textColor = .black
        
        titleLabel.layer.removeAllAnimations()
        titleLabel.layer.removeAllAnimations()
        titleLabel.layoutIfNeeded()
        titleLabel.textColor = .black
        
        isSound = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 15))
        
        
        titleLabel.frame = CGRect(x: 45,
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

        startStopButton.frame = CGRect(x: 5,
                                       y: 105,
                                       width: 50,
                                       height: 45
            )
        
        settingButton.frame = CGRect(x: 58,
                                         y: 105,
                                         width: 98,
                                         height: 45
            )
    }
}

