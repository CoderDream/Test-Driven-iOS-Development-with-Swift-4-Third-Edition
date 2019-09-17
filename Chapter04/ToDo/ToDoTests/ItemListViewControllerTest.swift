//
//  ItemListViewControllerTest.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        let sut = ItemListViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "ItemListViewController")
        let sut = viewController
            as! ItemListViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "ItemListViewController")
        let sut = viewController
            as! ItemListViewController
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }

}
