//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by CoderDream on 2019/4/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import FirstDemo

class FirstDemoTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_NumberOfVowels_WhenPassedDominik_ReturnsThree() {
        let string = "Dominik"
        let numberOfVowels = viewController.numberOfVowels(in: string)
        XCTAssertEqual(numberOfVowels, 3,
                       "should find 3 vowels in Dominik")
    }
    
    func test_MakeHeadline_ReturnsStringWithEachWordStartCapital() {
        let string = "this is A test headline"
        let headline = viewController.makeHeadline(from: string)
        XCTAssertEqual(headline, "This Is A Test Headline")
    }
    
    func test_MakeHeadline_ReturnsStringWithEachWordStartCapital2() {
        let string = "Here is another Example"
        let headline = viewController.makeHeadline(from: string)
        XCTAssertEqual(headline, "Here Is Another Example")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
