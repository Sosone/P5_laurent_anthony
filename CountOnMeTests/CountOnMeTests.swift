//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Anthony Laurent on 24/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var countOnMe: Calculator!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countOnMe = Calculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countOnMe = nil
    }

    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
