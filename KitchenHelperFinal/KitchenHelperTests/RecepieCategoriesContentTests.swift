//
//  RecepieCategoriesContentTests.swift
//  KitchenHelperTests
//
//  Created by dfg on 07.01.2023.
//

import XCTest
@testable import KitchenHelper

class RecepieCategoriesContentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // check whether InteractorRecepiesCategoriesContent saves categories
    func testRecepiesCategoriesContentInteractorCreateCoreDataItem() throws {
        let recepiesCategoriesInteractor = InteractorRecepiesCategoriesContent()
        
        recepiesCategoriesInteractor.createItem(id: "123", name: "testItem", imageUrl: "123")
        
        recepiesCategoriesInteractor.getAllItems()
        
        let allItems = recepiesCategoriesInteractor.savedCategories
        
        
        XCTAssertEqual(allItems.last?.name, "testItem")
      
    }
    
    // check whether InteractorRecepiesCategoriesContent deletes all categories
    func testRecepiesCategoriesContentInteractorDeleteAllItems() throws {
        let recepiesCategoriesInteractorContent = InteractorRecepiesCategoriesContent()
        
        recepiesCategoriesInteractorContent.createItem(id: "123", name: "testItem", imageUrl: "123")
        
        recepiesCategoriesInteractorContent.getAllItems()
        
        var allItems = recepiesCategoriesInteractorContent.savedCategories
        
        XCTAssertEqual(allItems.last?.name, "testItem")
        
        recepiesCategoriesInteractorContent.deleteAllItems()
        
        recepiesCategoriesInteractorContent.getAllItems()
        
        allItems = recepiesCategoriesInteractorContent.savedCategories
        

        XCTAssertEqual(allItems.count, 0)
    }
    
    // check whether RecepiesCategoriesContentViewController loads categories
    func testRecepiesCategoriesContentViewLoadCategories() throws {
        let recepiesCategoriesContentViewController = RecepiesCategoriesContentViewController()
        
        var categories = [KitchenHelper.CategoryContent]()
        
        categories.append(KitchenHelper.CategoryContent(id: "123", name: "Beef", imageUrl: "123"))
        
        categories.append(KitchenHelper.CategoryContent(id: "123", name: "Pasta", imageUrl: "123"))
        
        recepiesCategoriesContentViewController.loadCategoryContent(categoryContent: categories)
        

        XCTAssertNotEqual(recepiesCategoriesContentViewController.models.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

