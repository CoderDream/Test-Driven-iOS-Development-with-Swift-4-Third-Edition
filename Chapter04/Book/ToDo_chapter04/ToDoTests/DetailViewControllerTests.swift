//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by dasdom on 27.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    // 详情视图控制器
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        // 故事版
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        // 通过故事版创建详情视图控制器对象
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "DetailViewController")
            as? DetailViewController
        // 加载视图控制器
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 判断是否有标题标签
    func test_HasTitleLabel() {
        // 获得标题标签
        let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        // sut.view里包含标签标签
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    // 判断是否有地图视图对象
    func test_HasMapView() {
        // 获得地图视图对象
        let mapViewIsSubView = sut.mapView?.isDescendant(of: sut.view) ?? false
        // sut.view里包含地图视图对象
        XCTAssertTrue(mapViewIsSubView)
    }
    
    // 测试设置事项信息
    func test_SettingItemInfo_SetsTextsToLabels() {
        // 创建地理位置对象
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
        // 创建地点对象，参数为名称和地理位置
        let location = Location(name: "Foo", coordinate: coordinate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: "08/27/2017")
        let timestamp = date?.timeIntervalSince1970
        // 根据标题、描述、时间戳和地点创建事项
        let item = ToDoItem(title: "Bar",
                            itemDescription: "Baz",
                            timestamp: timestamp,
                            location: location)
        // 新建项目管理对象
        let itemManager = ItemManager()
        // 添加项目
        itemManager.add(item)
        // 设置视图控制器的项目信息
        sut.itemInfo = (itemManager, 0)
        // 开始转场
        sut.beginAppearanceTransition(true, animated: true)
        // 结束转场
        sut.endAppearanceTransition()
        // 判断标题文本是否相等
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        // 判断日期文本是否相等
        XCTAssertEqual(sut.dateLabel.text, "08/27/2017")
        // 判断地点文本是否相等
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        // 判断描述文本是否相等
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        // 判断精度信息是否相等
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       coordinate.latitude,
                       accuracy: 0.001)
        // 判断维度信息是否相等
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       coordinate.longitude,
                       accuracy: 0.001)
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        // 新建项目管理对象
        let itemManager = ItemManager()
        // 添加匿名项目对象
        itemManager.add(ToDoItem(title: "Foo"))
        // 设置视图控制器的项目信息
        sut.itemInfo = (itemManager, 0)
        // 完成项目
        sut.checkItem()
        // 判断待办数目是否为0
        XCTAssertEqual(itemManager.toDoCount, 0)
        // 判断待办数目是否为1
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
