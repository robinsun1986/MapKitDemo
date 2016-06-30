//
//  MapKitDemoUITests.swift
//  MapKitDemoUITests
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import XCTest

/*Sends a tap event to a hittable/unhittable element.*/
extension XCUIElement {
    func forceTapElement() {
        if self.hittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinateWithNormalizedOffset(CGVectorMake(0.0, 0.0))
            coordinate.tap()
        }
    }
}

class MapKitDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFlow() {
        
//        let app = XCUIApplication()
//        app.otherElements.containingType(.NavigationBar, identifier:"Search Country").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.SearchField).element.tap()
//        app.searchFields.containingType(.Button, identifier:"Clear text").element

        
        let app = XCUIApplication()
        app.otherElements.containingType(.NavigationBar, identifier:"Search Country").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.SearchField).element.tap()
        app.otherElements.containingType(.NavigationBar, identifier:"Search Country").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.SearchField).element.typeText("australia")
        // tap first cell
        app.tables.childrenMatchingType(.Cell).elementBoundByIndex(0).tap()
        // tap "watch" TODO
        
        // tap watchlist button
        app.buttons["ic visibility white"].tap()
        // tap assessment button
        app.buttons["ic assessment white"].tap()
        
    }
}
