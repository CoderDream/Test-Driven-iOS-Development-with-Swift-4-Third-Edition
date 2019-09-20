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
    
    var sut: ItemListViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "ItemListViewController")
        sut = viewController  as? ItemListViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here.
    }

    // 视图控制器加载完毕后，表格视图不为空
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    // 视图控制器加载完毕后，表格视图不为空
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    // 视图控制器加载完毕后，表格视图的数据源为ItemListDataProvider
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    // 视图控制器加载完毕后，表格视图的代理为ItemListDataProvider
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    // 视图控制器加载完毕后，表格视图的代理和数据源是同一个对象
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(
            sut.tableView.dataSource as? ItemListDataProvider,
            sut.tableView.delegate as? ItemListDataProvider)
    }
}
