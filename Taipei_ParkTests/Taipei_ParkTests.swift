//
//  Taipei_ParkTests.swift
//  Taipei_ParkTests
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import XCTest
@testable import Taipei_Park

class Taipei_ParkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestParkInfo() {
        let exp = self.expectation(description: "Expectation")
        DataManager.sharedManager.requestParkInfo { (spots, success) in
            XCTAssert(success, "api issue")
            XCTAssert(spots != nil)
            XCTAssert(spots!.count > 0)
            for key in spots!.keys {
                for spot in spots![key]! {
                    XCTAssert(spot.name != nil && !spot.name.isEmpty)
                    XCTAssert(spot.parkName != nil && !spot.parkName.isEmpty)
                    XCTAssert(spot.introduction != nil, "introduction: \(spot.introduction!)")
                }
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 30) { (exp) in
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
