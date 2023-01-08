//
//  ViewOnboarding.swift
//  KitchenHelper
//
//  Created by dfg on 18.12.2022.
//

import UIKit

protocol AnyViewOnboarding {
}

class ViewOnboarding: UIViewController, AnyViewOnboarding {
    
    func changeImage(imageIndex: Int) {
        UIView.transition(with: descImage,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.descImage.image = self.appImages[imageIndex] },
                          completion: nil)
    }
    
    @objc func onNext() {
        currAppImageIndex += 1
        if (currAppImageIndex == appImages.count) {
            currAppImageIndex = 0
        }
        changeImage(imageIndex: currAppImageIndex)
    }
    
    @objc func onPrev() {
        currAppImageIndex -= 1
        if (currAppImageIndex < 0) {
            currAppImageIndex = appImages.count - 1
        }
        changeImage(imageIndex: currAppImageIndex)
        
    }
    
    @objc func onCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    let viewWrapper = UIScrollView()
    
    
    private let descImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "appImage1")!
        return image
    }()
    
    private let appImage1 = UIImage(named: "appImage1")!
    private let appImage2 = UIImage(named: "appImage2")!
    private let appImage3 = UIImage(named: "appImage3")!
    private let appImage4 = UIImage(named: "appImage4")!
    private let appImage5 = UIImage(named: "appImage5")!
    private let appImage6 = UIImage(named: "appImage6")!
    private let appImage7 = UIImage(named: "appImage7")!
    private let appImage8 = UIImage(named: "appImage8")!
    private let appImage9 = UIImage(named: "appImage9")!
    private let appImage10 = UIImage(named: "appImage10")!
    private let appImage11 = UIImage(named: "appImage11")!
    private let appImage12 = UIImage(named: "appImage12")!
    private let appImage13 = UIImage(named: "appImage13")!
    private let appImage14 = UIImage(named: "appImage14")!
    private let appImage15 = UIImage(named: "appImage15")!
    private let appImage16 = UIImage(named: "appImage16")!
    private let appImage17 = UIImage(named: "appImage17")!
    private let appImage18 = UIImage(named: "appImage18")!
    private let appImage19 = UIImage(named: "appImage19")!
    
    var appImages = [UIImage]()
    var currAppImageIndex = 0
    
    let nextButton = UIButton(type: .system)
    let prevButton = UIButton(type: .system)
    let stopOnboardingButton = UIButton(type: .system)
    
    
    let wrapperMargin: CGFloat = 20
    let fieldsTopMargin: CGFloat = 30
    let buttonWidth: CGFloat = 70
    let buttonHeight: CGFloat = 50
    let buttonBottomMargin: CGFloat = 30
    let buttonLeftRightMargin: CGFloat = 10
    let descImageTopMargin: CGFloat = 78
    let descImageWidth: CGFloat = 300
    let descImageHeight: CGFloat = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appImages = [
            appImage1,
            appImage2,
            appImage3,
            appImage4,
            appImage5,
            appImage6,
            appImage7,
            appImage8,
            appImage9,
            appImage10,
            appImage11,
            appImage12,
            appImage13,
            appImage14,
            appImage15,
            appImage16,
            appImage17,
            appImage18,
            appImage19
        ]
        
        view.backgroundColor = .white

        viewWrapper.translatesAutoresizingMaskIntoConstraints = false

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        stopOnboardingButton.translatesAutoresizingMaskIntoConstraints = false
        descImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        nextButton.setTitle("Вперед", for: .normal)
        nextButton.backgroundColor = ColorsInstance.gray
        nextButton.layer.cornerRadius = 20
        nextButton.setTitleColor(.white, for: .normal)
        
        prevButton.setTitle("Назад", for: .normal)
        prevButton.backgroundColor = ColorsInstance.gray
        prevButton.layer.cornerRadius = 20
        prevButton.setTitleColor(.white, for: .normal)
        
        stopOnboardingButton.setTitle("Законить обзор", for: .normal)
        stopOnboardingButton.backgroundColor = ColorsInstance.green
        stopOnboardingButton.layer.cornerRadius = 20
        stopOnboardingButton.setTitleColor(.black, for: .normal)

        
        nextButton.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        
        prevButton.addTarget(self, action: #selector(onPrev), for: .touchUpInside)
        
        stopOnboardingButton.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        
        view.addSubview(viewWrapper)
        view.addSubview(descImage)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        view.addSubview(stopOnboardingButton)
        
        NSLayoutConstraint.activate([
            viewWrapper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: wrapperMargin),
            viewWrapper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: fieldsTopMargin),
            viewWrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
       ])
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            nextButton.bottomAnchor.constraint(equalTo: viewWrapper.bottomAnchor, constant: -buttonBottomMargin),
            nextButton.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor, constant: -buttonLeftRightMargin),
       ])
        
        NSLayoutConstraint.activate([
            stopOnboardingButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            stopOnboardingButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            stopOnboardingButton.bottomAnchor.constraint(equalTo: viewWrapper.bottomAnchor, constant: -buttonBottomMargin),
            stopOnboardingButton.leadingAnchor.constraint(equalTo: prevButton.trailingAnchor, constant: buttonLeftRightMargin),
            stopOnboardingButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -buttonLeftRightMargin),
       ])
        
        NSLayoutConstraint.activate([
            prevButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            prevButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            prevButton.bottomAnchor.constraint(equalTo: viewWrapper.bottomAnchor, constant: -buttonBottomMargin),
            prevButton.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor),
       ])
        
        NSLayoutConstraint.activate([
            descImage.heightAnchor.constraint(equalToConstant: descImageHeight),
            descImage.widthAnchor.constraint(equalToConstant: descImageWidth),
            descImage.topAnchor.constraint(equalTo: view.topAnchor, constant: descImageTopMargin ),
            descImage.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor),
       ])
    }
}

