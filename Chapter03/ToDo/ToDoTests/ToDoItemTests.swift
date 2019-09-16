//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Init_TakesTitle() {
        let item = ToDoItem(title: "Foo")
        XCTAssertNotNil(item, "item should not be nil")
    }

    func test_Init_TakesTitleAndDescription() {
        _ = ToDoItem(title: "Foo",
                     itemDescription: "Bar")
    }
}
