//
//  MapKitDemoTests.swift
//  MapKitDemoTests
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import XCTest

class MapKitDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func testLoadCountryData() {
        let countryList = MKDDataManager.sharedInstance.countryList
        XCTAssertEqual(countryList.count, 247)
        let firstCountry = countryList.first
        XCTAssertNotNil(firstCountry)
        XCTAssertEqual(firstCountry?.name, "Afghanistan")
        XCTAssertEqual(firstCountry?.countryCode, "AF")
        XCTAssertEqual(firstCountry?.continent, "Asia")
        XCTAssertEqual(firstCountry?.population, 32564342)
        XCTAssertEqual(firstCountry?.area, 652230)
        XCTAssertEqual(firstCountry?.coastline, 0)
        XCTAssertEqual(firstCountry?.currency, "Afghani")
        XCTAssertEqual(firstCountry?.currencyCode, "AFN")
        XCTAssertEqual(firstCountry?.birthrate, 38.6)
        XCTAssertEqual(firstCountry?.deathrate, 13.9)
        XCTAssertEqual(firstCountry?.lifeExpectancy, 50.9)
        XCTAssertEqual(firstCountry?.latitude, 33.8287)
        XCTAssertEqual(firstCountry?.longitude, 65.6582)
    }
    
    func testAddToWatchlist() {
        let countryList = MKDDataManager.sharedInstance.countryList
        let firstCountry = countryList[0]
        let secondCountry = countryList[1]
        MKDDataManager.sharedInstance.addToWatchlist(firstCountry)
        XCTAssertEqual(MKDDataManager.sharedInstance.watchlist.count, 1)
        MKDDataManager.sharedInstance.addToWatchlist(firstCountry)
        XCTAssertEqual(MKDDataManager.sharedInstance.watchlist.count, 1)
        MKDDataManager.sharedInstance.addToWatchlist(secondCountry)
        XCTAssertEqual(MKDDataManager.sharedInstance.watchlist.count, 2)
        MKDDataManager.sharedInstance.addToWatchlist(secondCountry)
        XCTAssertEqual(MKDDataManager.sharedInstance.watchlist.count, 2)
    }
    
    func testExistInWatchlist() {
        let countryList = MKDDataManager.sharedInstance.countryList
        let firstCountry = countryList[0]
        let secondCountry = countryList[1]
        MKDDataManager.sharedInstance.addToWatchlist(firstCountry)
        XCTAssertTrue(MKDDataManager.sharedInstance.existInWatchlist(firstCountry))
        XCTAssertFalse(MKDDataManager.sharedInstance.existInWatchlist(secondCountry))
        MKDDataManager.sharedInstance.addToWatchlist(secondCountry)
        XCTAssertTrue(MKDDataManager.sharedInstance.existInWatchlist(firstCountry))
        XCTAssertTrue(MKDDataManager.sharedInstance.existInWatchlist(secondCountry))
    }
    
    func testSearchByKeyword() {
        let keyword1 = "aust"
        let results1 = MKDDataManager.sharedInstance.searchBy(keyword1)
        XCTAssertEqual(results1.count, 2)
        let _ = results1.flatMap {
            XCTAssertTrue( $0.name?.lowercaseString.containsString(keyword1.lowercaseString) ?? false)
        }
        
        let keyword2 = "chi"
        let results2 = MKDDataManager.sharedInstance.searchBy(keyword2)
        XCTAssertEqual(results2.count, 2)
        let _ = results2.flatMap {
            XCTAssertTrue( $0.name?.lowercaseString.containsString(keyword2.lowercaseString) ?? false)
        }
    }
}











