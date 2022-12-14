//
//  KitchenHelperTests.swift
//  KitchenHelperTests
//
//  Created by dfg on 18.09.2022.
//

import XCTest
@testable import KitchenHelper

class KitchenHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // check whether RecepiesCategoriesInteractor saves categories
    func testRecepiesCategoriesInteractorCreateCoreDataItem() throws {
        let recepiesCategoriesInteractor = InteractorRecepiesCategories()
        
        recepiesCategoriesInteractor.createItem(id: "123", name: "testItem", imageUrl: "123", descriptionAtr: "testItem description")
        
        recepiesCategoriesInteractor.getAllItems()
        
        let allItems = recepiesCategoriesInteractor.savedCategories
        
        
        XCTAssertEqual(allItems.last?.name, "testItem")
      
    }
    
    // check whether RecepiesCategoriesInteractor deletes all categories
    func testRecepiesCategoriesInteractorDeleteAllItems() throws {
        let recepiesCategoriesInteractor = InteractorRecepiesCategories()
        
        recepiesCategoriesInteractor.createItem(id: "123", name: "testItem", imageUrl: "123", descriptionAtr: "testItem description")
        
        recepiesCategoriesInteractor.getAllItems()
        
        var allItems = recepiesCategoriesInteractor.savedCategories
        
        XCTAssertEqual(allItems.last?.name, "testItem")
        
        recepiesCategoriesInteractor.deleteAllItems()
        
        recepiesCategoriesInteractor.getAllItems()
        
        allItems = recepiesCategoriesInteractor.savedCategories
        

        XCTAssertEqual(allItems.count, 0)
    }
    
    // check whether RecepiesCategoriesInteractor loads categories
    func testRecepiesCategoriesViewLoadCategories() throws {
        let recepiesCategoriesViewController = RecepiesCategoriesViewController()
        
        var categories = [KitchenHelper.Category]()
        
        categories.append(KitchenHelper.Category(id: "123", name: "Beef", imageUrl: "123", description: "Beef Description"))
        
        categories.append(KitchenHelper.Category(id: "123", name: "Pasta", imageUrl: "123", description: "Pasta Description"))
        
        recepiesCategoriesViewController.loadCategories(categories: categories)
        

        XCTAssertNotEqual(recepiesCategoriesViewController.models.count, 0)
    }

    // check whether RecepiesCategoriesInteractor fetches categories
    func testRecepiesCategoriesSaveFunc() throws {
        let mockNetworkService = MockNetworkService()
        
        let interactorRecepiesCategories = InteractorRecepiesCategories(networkService: mockNetworkService)
        
        interactorRecepiesCategories.fetchRecepiesCategories()
        
        interactorRecepiesCategories.getAllItems()
        
        XCTAssertNotEqual(interactorRecepiesCategories.savedCategories.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
