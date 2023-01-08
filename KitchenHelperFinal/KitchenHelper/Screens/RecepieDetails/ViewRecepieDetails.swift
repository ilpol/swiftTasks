//
//  ViewRecepiesCategories.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import UIKit

protocol AnyViewRecepieDetails {
    func loadRecepieDetails(recepieDetails: [RecepieDetails])
    var presenter: AnyPresenterRecepieDetails? {get set}
    func setRecepieId(idToSet: String)
}

class RecepieDetailsViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnyViewRecepieDetails {
    
    let cellsPerRow = 2
    let margin: CGFloat = 20
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func getIngridientNameByPosition(pos: Int) -> String {
        if (models.count == 0) {
            return ""
        }
        if (pos == 0) {
            return models[0].ingredient1 ?? ""
        } else if (pos == 1) {
            return models[0].ingredient2 ?? ""
        } else if (pos == 2) {
            return models[0].ingredient3 ?? ""
        } else if (pos == 3) {
            return models[0].ingredient4 ?? ""
        } else if (pos == 4) {
            return models[0].ingredient5 ?? ""
        } else if (pos == 5) {
            return models[0].ingredient6 ?? ""
        } else if (pos == 6) {
            return models[0].ingredient7 ?? ""
        }

        return models[0].ingredient1 ?? ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecepieDetailsIngridientCell", for: indexPath) as! RecepieDetailsIngridientCell
        cell.setContent(name: getIngridientNameByPosition(pos: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 180, height: 150)
    }
    
    
    let ingridientsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryItemContentCell.self, forCellWithReuseIdentifier: "RecepieDetailsIngridientCell")
        return cv
    }()
    
    let viewWrapper = UIScrollView()
    
    var titleLabel = UILabel()
    var ingridientsTitleLabel = UILabel()
    var recepieTitleLabel = UILabel()
    var descriptionLabel = UILabel()

    let ingridientsTitleText = "Ingridients"
    var recepieTitleText = "Recepie"
    
    private let recepieImage: UIImageView = { () -> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "drink")!
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        return image
    }()
    

    let tableView = UITableView()
    var id = "" {
        didSet {
            presenter?.onLoadView(id: id)
        }
    }
    var presenter: AnyPresenterRecepieDetails?
    var models = [RecepieDetails]()
    var isLoading = false {
        didSet {
            if (isLoading) {
                loaderAnimate(isRunning: true)
            } else {
                loaderAnimate(isRunning: false)
            }
        }
    }
    let frameLoaderIcon = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    var loaderIcon = UIView()
    let loaderAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    func setRecepieId(idToSet: String) {
        id = idToSet
    }
    
    let wrapperMargin: CGFloat = 20
    let wrapperTopMargin: CGFloat = 30
    var isFullImage = true
    
    func updateConstraints() {
        NSLayoutConstraint.activate([
            recepieImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            recepieImage.heightAnchor.constraint(equalToConstant: 50),
            recepieImage.bottomAnchor.constraint(equalTo: viewWrapper.topAnchor),
            recepieImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            recepieImage.rightAnchor.constraint(equalTo: view.rightAnchor)
       ])
        NSLayoutConstraint.activate([
            viewWrapper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: wrapperMargin),
            viewWrapper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -wrapperMargin),
            
            viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            viewWrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
       ])
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: recepieImage.bottomAnchor,constant: 200),
       ])
        NSLayoutConstraint.activate([
            ingridientsTitleLabel.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            ingridientsTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            ingridientsTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
       ])
        
        NSLayoutConstraint.activate([
            ingridientsCollectionView.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            ingridientsCollectionView.heightAnchor.constraint(equalToConstant: 140),
            ingridientsCollectionView.topAnchor.constraint(equalTo: ingridientsTitleLabel.bottomAnchor,constant: 10),
       ])
        
        NSLayoutConstraint.activate([
            recepieTitleLabel.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            recepieTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            recepieTitleLabel.topAnchor.constraint(equalTo: ingridientsCollectionView.bottomAnchor,constant: 20),
       ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.widthAnchor.constraint(equalTo: viewWrapper.widthAnchor, multiplier : 1),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 500),
            descriptionLabel.topAnchor.constraint(equalTo: recepieTitleLabel.bottomAnchor,constant: 10),
       ])
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0 && isFullImage) {
            recepieImage.removeFromSuperview()
            viewWrapper.addSubview(recepieImage)
            
            isFullImage = false
            updateConstraints()
        } else if (scrollView.contentOffset.y <= 0 && !isFullImage) {
            isFullImage = true
            recepieImage.removeFromSuperview()
            view.addSubview(recepieImage)
            updateConstraints()
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWrapper.delegate = self
        viewWrapper.translatesAutoresizingMaskIntoConstraints = false
        recepieImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ingridientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ingridientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recepieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = .white
        
        titleLabel.font = titleLabel.font.withSize(20)
        titleLabel.numberOfLines = 2
        ingridientsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        recepieTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 100
        
        titleLabel.layer.zPosition = 2;
        
        view.addSubview(viewWrapper)
        view.addSubview(recepieImage)
        viewWrapper.addSubview(titleLabel)
        viewWrapper.addSubview(descriptionLabel)
        viewWrapper.addSubview(ingridientsTitleLabel)
        viewWrapper.addSubview(recepieTitleLabel)
        
        ingridientsCollectionView.register(RecepieDetailsIngridientCell.self, forCellWithReuseIdentifier: "RecepieDetailsIngridientCell")
        ingridientsCollectionView.dataSource = self
        ingridientsCollectionView.delegate = self
        ingridientsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let layout = ingridientsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        viewWrapper.addSubview(ingridientsCollectionView)
        
        updateConstraints()
        
        loaderIcon = UIView(frame: frameLoaderIcon)
        
        loaderIcon.backgroundColor = .black
        view.addSubview(loaderIcon)
        
        loaderIcon.center = CGPoint(x: view.frame.size.width  / 2,
                                     y: view.frame.size.height / 2)
        
        loaderIcon.isHidden = true
        
        loaderAnimation.duration = 3
        loaderAnimation.toValue = 20
        loaderAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        loaderIcon.layer.add(loaderAnimation, forKey: nil)
        isLoading = true
    }
    
    
    func loaderAnimate (isRunning: Bool) {
        if (isRunning) {
            loaderIcon.isHidden = false
            loaderIcon.layer.add(loaderAnimation, forKey: nil)
        } else {
            loaderIcon.isHidden = true
            loaderIcon.layer.removeAllAnimations()
        }
    }
    func loadRecepieDetails(recepieDetails: [RecepieDetails]) {
        titleLabel.text = recepieDetails[0].name
        descriptionLabel.text = recepieDetails[0].instructions
        
        ingridientsTitleLabel.text = ingridientsTitleText
        recepieTitleLabel.text = recepieTitleText
        
        titleLabel.numberOfLines = 2

        models = recepieDetails
        recepieImage.downloadFrom(from: recepieDetails[0].imageUrl)
        self.ingridientsCollectionView.reloadData()
        isLoading = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count // recepies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .red

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0;
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        viewWrapper.contentSize = CGSize(width: 0, height: 2000)
    }
}



