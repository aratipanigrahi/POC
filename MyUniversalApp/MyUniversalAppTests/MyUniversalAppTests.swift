//
//  MyUniversalAppTests.swift
//  MyUniversalAppTests
//
//  Created by arati.panigrahi on 20/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import XCTest
@testable import MyUniversalApp

class MyUniversalAppTests: XCTestCase {

    var serviceCore = ServiceCore()
    var detailsArray: [Country] = []
    let urlStr = Constants.url
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    /* Given: A ServiceManager
     When:  Fetching a successful  result
     Then:  No error is returned
     */
    
    func testFetchCountyDetailSuccess(){
        let expectation = self.expectation(description: "Fetch Block never called")
        serviceCore.getCountryDetails(url: urlStr) { results, errorMessage in
            XCTAssertNotNil(results)
            XCTAssertNil(errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            Swift.print(error?.localizedDescription as Any)
        }
    }
    
    
    /* Given: A ServiceManager
    When:  Fetching a failed  result
    Then:  An error is returned
    */
    func testFetchCountyDetailFail() {
        let expectation = self.expectation(description: "testFetchCountyDetailFail")
        
        let invalidURL = "testurl"
        serviceCore.getCountryDetails(url: invalidURL) { results, error in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (error) in
            Swift.print(error ?? "")
        }
    }
}
