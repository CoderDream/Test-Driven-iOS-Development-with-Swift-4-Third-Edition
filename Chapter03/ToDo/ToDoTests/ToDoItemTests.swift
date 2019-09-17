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
        // Put setup code here. 
    }

    override func tearDown() {
        // Put teardown code here.
    }
    
    // 通过标题初始化对象
    func test_Init_WhenGivenTitle_SetsTitle() {
        let item = ToDoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo",
                       "should set title")
    }

    // 通过标题和描述初始化对象
    func test_Init_WhenGivenDescription_SetsDescription() {
        let item = ToDoItem(title: "",
                            itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar",
                       "should set itemDescription")
    }
    
    // 通过标题和时间戳初始化对象
    func test_Init_SetsTimestamp() {
        let item = ToDoItem(title: "",
                            timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0,
                       "should set timestamp")
    }
    
    // 初始化对象，并设置对象的属性对象
    func test_Init_SetsLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "",
                            location: location)
        XCTAssertEqual(item.location?.name,
                       location.name,
                       "should set location")
    }
    
    // 名称相等时对象相等
    func text_EqualItems_AreEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        XCTAssertEqual(first, second)
    }
    
    // 地址的名称不相等时对象不相等
    func test_Items_WhenLocationDiffers_AreNotEqual() {
        let first = ToDoItem(title: "",
                             location: Location(name: "Foo"))
        let second = ToDoItem(title: "",
                              location: Location(name: "Bar"))
        XCTAssertNotEqual(first, second)
    }
    
    // 地址的名称不相等时对象不相等（和nil比较）
    func test_Items_WhenOneLocationIsNil_AreNotEqual() {
        var first = ToDoItem(title: "",
                             location: Location(name: "Foo"))
        var second = ToDoItem(title: "",
                              location: nil)
        XCTAssertNotEqual(first, second)
        
        first = ToDoItem(title: "",
                         location: nil)
        second = ToDoItem(title: "",
                          location: Location(name: "Foo"))
        XCTAssertNotEqual(first, second)
    }
    
    // 时间戳不相等时对象不相等
    func test_Items_WhenTimestampsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo",
                             timestamp: 1.0)
        let second = ToDoItem(title: "Foo",
                              timestamp: 0.0)
        XCTAssertNotEqual(first, second)
    }
    
    // 描述不相等时对象不相等
    func test_Items_WhenDescriptionsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo",
                             itemDescription: "Bar")
        let second = ToDoItem(title: "Foo",
                              itemDescription: "Baz")
        XCTAssertNotEqual(first, second)
    }
    
    // 名称不相等时对象不相等
    func test_Items_WhenTitlesDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Bar")
        XCTAssertNotEqual(first, second)
    }
}
