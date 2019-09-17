//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!

    override func setUp() {
        sut = ItemManager()
    }

    override func tearDown() {
        // Put teardown code here.
    }

    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }

    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
}
