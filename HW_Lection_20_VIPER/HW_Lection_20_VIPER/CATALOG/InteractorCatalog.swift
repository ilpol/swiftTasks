//
//  Interactor.swift
//  HW_Lection_20_VIPER
//
//  Created by dfg on 11.11.2022.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getFruits()
}

class FruitsInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func getFruits() {
        guard let url = URL(string: "https://www.fruityvice.com/api/fruit/all") else { return }
        let task = URLSession.shared.dataTask(with: url) {
           [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchFruits(with: .failure(FetchCatalogError.failed))
                return
            }
        
            do {
                let entities = try JSONDecoder().decode([Fruit].self, from: data)
                self?.presenter?.interactorDidFetchFruits(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchFruits(with: .failure(error))
                
            }
        }
        task.resume()
    }
    
}

