//
//  ModelTest.swift
//  MyUniversalAppTests
//
//  Created by arati.panigrahi on 24/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import XCTest
@testable import MyUniversalApp

class ModelTest: XCTestCase {

    var details:CountryDetails!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        details = CountryDetails(title: "Model", rows: [])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        details = nil
    }

    
    //Mark :Model
    func testModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
            XCTAssertTrue(!details.title.isEmpty)
            XCTAssertTrue(details.rows.count == 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
