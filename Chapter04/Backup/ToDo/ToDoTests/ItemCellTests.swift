//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/19.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "ItemListViewController")
            as! ItemListViewController
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView?.dataSource = dataSource
        
        //tableView?.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        cell = tableView?.dequeueReusableCell(
            withIdentifier: "ItemCell",
            for: IndexPath(row: 0, section: 0)) as? ItemCell
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasNameLabel() {
        print(cell.titleLabel)
        //XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }

//    var tableView: UITableView!
//    let dataSource = FakeDataSource()
//    var cell: ItemCell!
//
//    override func setUp() {
//        super.setUp()
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard
//            .instantiateViewController(
//                withIdentifier: "ItemListViewController")
//            as! ItemListViewController
//
//        controller.loadViewIfNeeded()
//
//        tableView = controller.tableView
//        tableView?.dataSource = dataSource
//        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
//
//        cell = tableView?.dequeueReusableCell(
//            withIdentifier: "ItemCell",
//            for: IndexPath(row: 0, section: 0)) as? ItemCell
//
//    }
//
//    override func tearDown() {
//    }
//
//    func test_HasNameLabel() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard
//            .instantiateViewController(withIdentifier: "ItemListViewController")
//            as! ItemListViewController
//        controller.loadViewIfNeeded()
//        let tableView = controller.tableView
//        let dataSource = FakeDataSource()
//        tableView?.dataSource = dataSource
//        tableView?.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
//        let cell = tableView?.dequeueReusableCell(
//            withIdentifier: "ItemCell",
//            for: IndexPath(row: 0, section: 0)) as! ItemCell
//        print(cell.titleLabel)
//        //XCTAssertNotNil(cell.titleLabel)
//        //print(cell)
//        //XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
//    }
    
//    func test_HasNameLabel() {
//        print(cell.titleLabel)
//        print(cell.titleLabel.isDescendant(of: cell.contentView))
//        //XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
//    }
    
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
                return UITableViewCell()
        }
    }
}
