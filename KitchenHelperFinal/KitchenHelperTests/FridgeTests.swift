//
//  FridgeTests.swift
//  KitchenHelperTests
//
//  Created by dfg on 08.01.2023.
//

import XCTest
@testable import KitchenHelper

class FridgeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // check whether FridgeItemFormInteractor saves categories
    func testFridgeInteractorCreateCoreDataItem() throws {
        let fridgeItemFormInteractor = FridgeItemFormInteractor()
        
        fridgeItemFormInteractor.createItem(name: "Сок", itemDescription: "Пить перед завтраком", id: "12", itemImage: UIImage(), overdueDate: Date(), isOverdueNotificationSwitch: false)
        
        let fridgeInteractor = FridgeInteractor()
        
        fridgeInteractor.fetchFridgeItems()
        
        let allItems = fridgeInteractor.fridgeItems
        
        
        XCTAssertEqual(allItems.last?.name, "Сок")
      
    }
    
    // check whether FridgeItemFormInteractor deletes all categories
    func testFridgeInteractorDeleteAllItems() throws {
        let fridgeItemFormInteractor = FridgeItemFormInteractor()
        
        fridgeItemFormInteractor.createItem(name: "Сок", itemDescription: "Пить перед завтраком", id: "12", itemImage: UIImage(), overdueDate: Date(), isOverdueNotificationSwitch: false)
        
        let fridgeInteractor = FridgeInteractor()
        
        fridgeInteractor.fetchFridgeItems()
        
        let allItems = fridgeInteractor.fridgeItems
        
        fridgeInteractor.deleteAllItems()

        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            XCTAssertEqual(allItems.count, 0)
        }
        
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

