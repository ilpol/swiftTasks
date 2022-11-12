//
//  NamesIterator.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 12.11.2022.
//

import Foundation

class NamesCollection {
    var items = [Fruit]()
    
    init(with names: [Fruit]) {
        items = names
    }
}

extension NamesCollection: Sequence {
    func makeIterator() -> NamesIterator {
        return NamesIterator(collectionToSet: self)
    }
}

class NamesIterator: IteratorProtocol {
    
    private let collection: NamesCollection
    private var index = 0
    
    init (collectionToSet: NamesCollection) {
        collection = collectionToSet
    }
    
    func next() -> String? {
        defer {index += 1}
        return index < collection.items.count ? collection.items[index].name : nil
    }
    
}
