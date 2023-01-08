//
//  CategoryItemCell.swift
//  KitchenHelper
//
//  Created by dfg on 16.11.2022.
//

import UIKit

class CategoryItemContentCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var timerLabel = UILabel()
    var startStopButton = UIButton()
    var wrapView = UIView()
    var isTimerRunning = false
    var timer: Timer? = nil
    var totalSeconds = 0
    private let recepieImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        return image
    }()
    
    func setContent(name: String, imageUrl: String) {
        titleLabel.text = name
        recepieImage.downloadFrom(from: imageUrl)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(recepieImage)
        contentView.addSubview(wrapView)
        wrapView.backgroundColor = .clear
        startStopButton.backgroundColor = ColorsInstance.green
        
        recepieImage.layer.borderWidth = 1
        recepieImage.layer.masksToBounds = false
        recepieImage.layer.borderColor = UIColor.clear.cgColor
        recepieImage.layer.cornerRadius = recepieImage.frame.height/2
        recepieImage.clipsToBounds = true
        recepieImage.layer.cornerRadius = 10
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
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
        
        
        titleLabel.frame = CGRect(x: 5,
                                    y: 100,
                                    width: contentView.frame.width - 10,
                                    height: contentView.frame.size.height/2
            )
        recepieImage.frame = CGRect(x: 5,
                                    y: 10,
                                    width: contentView.frame.width - 10,
                                    height: contentView.frame.size.height/2
            )
        
        wrapView.frame = CGRect(x: 8,
                                y: 8,
                                    width: contentView.frame.width ,
                                height: contentView.frame.height
        )
    }
    
}

