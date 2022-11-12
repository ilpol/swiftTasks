//
//  CardModel.swift
//  HW_Lection_19_CollectionView
//
//  Created by dfg on 30.10.2022.
//

import UIKit

struct Card {
    let image: UIImage
    let title: String
}

let cards:[Card] = [
    Card(image: UIImage(named: "strawberry")!, title: "Клубника"),
    Card(image: UIImage(named: "pineapple")!, title: "Ананас"),
    Card(image: UIImage(named: "orange-juice")!, title: "Апельсин"),
    Card(image: UIImage(named: "lemon")!, title: "Лимон"),
    Card(image: UIImage(named: "kiwi")!, title: "Киви"),
    Card(image: UIImage(named: "drink")!, title: "Напиток"),
    Card(image: UIImage(named: "fruit")!, title: "Фрукты"),
    Card(image: UIImage(named: "cherries")!, title: "Вишня"),
    Card(image: UIImage(named: "bananas")!, title: "Бананы"),
    Card(image: UIImage(named: "apple")!, title: "Яблоко"),
]
