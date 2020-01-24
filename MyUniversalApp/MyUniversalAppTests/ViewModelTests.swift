//
//  ViewModelTests.swift
//  MyUniversalAppTests
//
//  Created by arati.panigrahi on 24/01/20.
//  Copyright © 2020 arati.panigrahi. All rights reserved.
//

import XCTest
@testable import MyUniversalApp

class ViewModelTests: XCTestCase {
    
    var displayble:CountryDisplaybleViewModel!
    let url = Constants.url
    var expectation = XCTestExpectation(description: "Data fetch")
    var stringUdate:String?{
        didSet {
            fetchResult()
        }
    }
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        displayble = CountryDisplaybleViewModel()
        displayble.didUpdate = {
            self.didUpdate()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        displayble = nil
    }

    //Mark :Test View model
    func testFetchDetails() {
        displayble.fetchCountryDetails(urlStr: url)
        wait(for: [expectation], timeout: 10.0)
    }
    
    func fetchResult(){
        if(!(self.stringUdate?.isEmpty)!){
            expectation.fulfill()
        
        }
    }
    func didUpdate(){
        stringUdate = "Updated"
        print("Did update called")
    }

}
