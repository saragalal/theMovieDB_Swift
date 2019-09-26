//
//  TheMovieDbHomeUITests.swift
//  TheMovieDbHomeUITests
//
//  Created by sara.galal on 9/25/19.
//  Copyright © 2019 Sara Galal. All rights reserved.
//

import XCTest
import UIKit
@testable import TheMovieDb

class TheMovieDbHomeUITests: XCTestCase {
    var app: XCUIApplication!
    var myTable: XCUIElementQuery!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        myTable = app.tables.matching(identifier: "HomeTableViewIdentifier")
     }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        myTable = nil
        app.terminate()
        app = nil
        
        
    }
    
    func testListItemISShown(){
        XCTAssert(myTable.staticTexts.count > 0)
        XCTAssertEqual(myTable.cells.count, 20 ,"Cells should be 20")
    }
    
    func testCellIsTapped(){
        let cell = myTable.cells.element(matching: .cell, identifier: "myCell_0")
        let detailsView = app.windows.element(matching: .any, identifier: "DetailsViewIdentifier")
        let myCollection = app.collectionViews.matching(identifier: "DetailsCollectionViewIdentifier")
         cell.tap()
       XCTAssertNotNil(detailsView)
       XCTAssertNotNil(myCollection)
    }
    
    func testScrollingTableView() {
     let cell19 = myTable.cells.element(matching: .cell, identifier: "myCell_19")
    XCTAssertFalse(cell19.isHittable)
    while cell19.isHittable == false {
            app.swipeUp()

        }
        let nextCell = myTable.cells.element(matching: .cell, identifier: "myCell_20")
        XCTAssert(nextCell.exists)
        XCTAssertEqual(myTable.cells.count, 40 ,"Cells should be 40")
    }
    
    func testPullToRefresh() {
        let refreshControl = app.staticTexts["refresh_control_label"]
       XCTAssertEqual(myTable.cells.count, 20 , "tableView cells count not equal 20")
        app.swipeDown()
     //myTable.element.gentleSwipe()
//       guard refreshControl.waitForExistence(timeout: 0.01) else {
//            return XCTFail("Refresh control label not found.")
//        }

//       let promise = expectation(description: "wait until get request")
 XCTAssertEqual(myTable.cells.count, 20 , "tableView cells count not equal 20")
//       promise.fulfill()
   }
}

extension XCUIElement {
  func gentleSwipe() {
    let half : CGFloat = 0.5
    let adjustment : CGFloat = 0.34
    let pressDuration : TimeInterval = 0.05
    let moreThanHalf = half + adjustment
    let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
    let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
    centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
    
    }
}
