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

    // 测试todo的数量
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }

    // 测试done的数量
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    // 增加一个项目
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(ToDoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    // 新增一个项目并查找该项目
    func test_ItemAt_ReturnsAddedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        let returnedItem = sut.item(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    // 新增一个项目并完成这个项目
    func test_CheckItemAt_ChangesCounts() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    // 新增两个项目，完成第一个项目
    func test_CheckItemAt_RemovesItFromToDoItems() {
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")
        sut.add(first)
        sut.add(second)
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.item(at: 0).title,
                       "Second")
    }
    
    // 判断两个对象是否相等（实现Equatable协议）
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
        XCTAssertEqual(returnedItem, item)
    }
    
    func test_RemoveAll_ResultsInCountsBeZero() {
        sut.add(ToDoItem(title: "Foo"))
        sut.add(ToDoItem(title: "Bar"))
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        sut.removeAll()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
}
