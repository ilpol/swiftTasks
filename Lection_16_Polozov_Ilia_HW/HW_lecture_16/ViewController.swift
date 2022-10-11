//
//  ViewController.swift
//  HW_lecture_16
//
//  Created by dfg on 11.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    var totalSeconds = 0
    var isRunning = false
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerView: UILabel!

    @IBAction func stopTimerAction(_ sender: Any) {
        stopTimer()
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    @IBAction func startTimerAction(_ sender: Any) {
        startTimer()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    func startTimer() {
        isRunning = true
        if (timer == nil) {
            timer = Timer(timeInterval: 1, target: self, selector: #selector(onTimerRunning(_:)), userInfo: nil, repeats: true)
            
            if (timer != nil) {
                RunLoop.current.add(timer!, forMode: .common)
            }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        stopTimer()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        if (isRunning) {
            startTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func onTimerRunning(_ timer: Timer) {
        totalSeconds += 1
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 3600) % 60
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        timerView.text = "\(minutesStr): \(secondsStr)"
    }
}

