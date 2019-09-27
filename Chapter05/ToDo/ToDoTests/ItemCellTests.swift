//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by dasdom on 27.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest

@testable import ToDo

class ItemCellTests: XCTestCase {
    // 表格视图属性
    var tableView: UITableView!
    // 数据源属性（内置伪数据源）
    let dataSource = FakeDataSource()
    // 表格的单元格
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        // 面板
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 通过面板实例化控制器对象
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "ItemListViewController")
            as! ItemListViewController
        // 加载控制器对象（生成控制器中的表格视图对象属性）
        controller.loadViewIfNeeded()
        // 设置表格视图属性
        tableView = controller.tableView
        // 设置数据源
        tableView?.dataSource = dataSource
        // 获取第1章节的第1个表格单元格
        cell = tableView?.dequeueReusableCell(
            withIdentifier: "ItemCell",
            for: IndexPath(row: 0, section: 0)) as? ItemCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // 测试是否有名称标签
    func test_HasNameLabel() {
        //print(cell.titleLabel)
        // 非空判断
        XCTAssertNotNil(cell.titleLabel)
        // 判断titleLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasLocationLabel() {
        // 判断locationLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasDateLabel() {
        // 判断dateLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ConfigCell_SetsTitle() {
        // 设置标题
        cell.configCell(with: ToDoItem(title: "Foo"))
        // 判断标题是否设置成功
        XCTAssertEqual(cell.titleLabel.text, "Foo")
    }
    
    func test_ConfigCell_SetsDate() {
        // 创建内置的日期格式化对象
        let dateFormatter = DateFormatter()
        // 设置日期格式
        dateFormatter.dateFormat = "MM/dd/yyyy"
        // 通过日期格式化对象创建日期对象
        let date = dateFormatter.date(from: "08/27/2017")
        // 创建时间戳对象
        let timestamp = date?.timeIntervalSince1970
        // 通过标题和时间戳设置cell
        cell.configCell(with: ToDoItem(title: "Foo",
                                       timestamp: timestamp))
        // 判断时间戳是否设置成功
        XCTAssertEqual(cell.dateLabel.text, "08/27/2017")
    }
    
    // 测试设置地点名称
    func test_ConfigCell_SetsLocation() {
        // 通过名称创建地点对象
        let location = Location(name: "Bar")
        // 通过标题和地点设置cell
        cell.configCell(with: ToDoItem(title: "Foo",
                                       location: location))
        // 判断地点是否设置成功
        XCTAssertEqual(cell.locationLabel.text, "Bar")
    }
    
    func test_Title_WhenItemIsChecked_IsStrokeThrough() {
        // 通过名称创建地点对象
        let location = Location(name: "Bar")
        // 通过标题、描述、时间戳和地点创建事项对象
        let item = ToDoItem(title: "Foo",
                            itemDescription: nil,
                            timestamp: 0,
                            location: location)
        // 通过事项对象和是否已检查设置单元格
        cell.configCell(with: item, checked: true)
        // 创建属性字符串
        let attributedString = NSAttributedString(
            string: "Foo",
            attributes: [NSAttributedStringKey.strikethroughStyle:
                NSUnderlineStyle.styleSingle.rawValue])
        // 判断属性字符串是否正确
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        // 判断地点标签对象是否不为空
        XCTAssertNil(cell.locationLabel.text)
        // 判断日期标签对象是否不为空
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    // 伪数据源
    class FakeDataSource: NSObject, UITableViewDataSource {
        // 设置章节数量
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        // 设置返回的单元格对象
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
                return UITableViewCell()
        }
    }
}
