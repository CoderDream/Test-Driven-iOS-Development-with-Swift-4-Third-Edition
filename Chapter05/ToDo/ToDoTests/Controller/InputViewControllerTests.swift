//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by dasdom on 28.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class InputViewControllerTests: XCTestCase {
    // 输入视图控制器
    var sut: InputViewController!
    // 模拟地理位置标签
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        // 故事版
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        // 通过故事版创建输入视图控制器对象
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "InputViewController")
            as? InputViewController
        // 加载视图控制器
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 判断是否有标题输入框
    func test_HasTitleTextField() {
        let titleTextFieldIsSubView =
            sut.titleTextField?.isDescendant(
                of: sut.view) ?? false
        XCTAssertTrue(titleTextFieldIsSubView)
    }
    
    // 保存带地理位置的项目
    func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        // 初始化日期对象
        let timestamp = 1456095600.0
        let date = Date(timeIntervalSince1970: timestamp)
        // 设置标题输入框的文本
        sut.titleTextField.text = "Foo"
        // 设置日期输入框的文本
        sut.dateTextField.text = dateFormatter.string(from: date)
        // 设置地点输入框的文本
        sut.locationTextField.text = "Bar"
        // 设置地址输入框的文本
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        // 设置描述输入框的文本
        sut.descriptionTextField.text = "Baz"
        // 创建模拟地理位置对象
        let mockGeocoder = MockGeocoder()
        // 设置视图控制器的地理位置对象
        sut.geocoder = mockGeocoder
        // 设置项目管理器
        sut.itemManager = ItemManager()
        // 保存项目
        sut.save()
        // 设置模拟地理位置标签
        placemark = MockPlacemark()
        // 创建2D地理位置对象
        let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                    -122.0300674)
        // 设置模拟地理位置标签的2D地理位置对象
        placemark.mockCoordinate = coordinate
        // 设置模拟位置对象的位置标签
        mockGeocoder.completionHandler?([placemark], nil)
        // 获取视图中的第一个项目对象
        let item = sut.itemManager?.item(at: 0)
        // 创建测试项目对象
        let testItem = ToDoItem(title: "Foo",
                                itemDescription: "Baz",
                                timestamp: 1456070400.0,
                                location: Location(name: "Bar",
                                                   coordinate: coordinate))
        // 测试视图中的对象和新建的测试对象是否相等
        //XCTAssertTrue(item == testItem)
        XCTAssertEqual(item, testItem)
    }
    
    // 测试保存按钮的响应事件
    func test_SaveButtonHasSaveAction() {
        // 获取保存按钮
        let saveButton: UIButton = sut.saveButton
        // 为保存按钮添加响应事件，并将此事件添加到actions对象中
        guard let actions = saveButton.actions(
            forTarget: sut,
            forControlEvent: .touchUpInside) else {
                XCTFail()
                return
        }
        // 判断actions对象中是否有save事件
        XCTAssertTrue(actions.contains("save"))
    }
    
//    func test_Geocoder_FetchesCoordinates() {
//        let geocoderAnswered = expectation(description: "Geocoder")
//        let address = "Infinite Loop 1, Cupertino"
//        CLGeocoder()
//            .geocodeAddressString(address) {
//                (placemarks, error) -> Void in
//                let coordinate =
//                    placemarks?.first?.location?.coordinate
//                guard let latitude =
//                    coordinate?.latitude else {
//                        XCTFail()
//                        return
//                }
//                guard let longitude =
//                    coordinate?.longitude else {
//                        XCTFail()
//                        return
//                }
//                XCTAssertEqual(latitude,
//                               37.3316,
//                               accuracy: 0.001)
//                XCTAssertEqual(longitude,
//                               -122.0300,
//                               accuracy: 0.001)
////                XCTAssertEqual(latitude,
////                               0.0,
////                               accuracy: 0.001)
////                XCTAssertEqual(longitude,
////                               0.0,
////                               accuracy: 0.001)
//                geocoderAnswered.fulfill()
//        }
//        waitForExpectations(timeout: 3, handler: nil)
//    }
    
    func test_Geocoder_FetchesCoordinates() {
        
        let geocoderAnswered = expectation(description: "Geocoder")
        
        //let address = "Infinite Loop 1, Cupertino"
        // 由于在中国苹果默认使用高德地图，所以要用中文地址
        let address = "光谷天地"
        CLGeocoder()
            .geocodeAddressString(address) {
                (placemarks, error) -> Void in
                
                let coordinate = placemarks?.first?.location?.coordinate
                //print(coordinate)
                guard let latitude =
                    coordinate?.latitude else {
                        XCTFail()
                        return
                }
                
                guard let longitude =
                    coordinate?.longitude else {
                        XCTFail()
                        return
                }
                
//                XCTAssertEqual(latitude,
//                               37.3316,
//                               accuracy: 0.001)
//                XCTAssertEqual(longitude,
//                               -122.0300,
//                               accuracy: 0.001)
                XCTAssertEqual(latitude,
                               30.477076,
                               accuracy: 0.00001)
                XCTAssertEqual(longitude,
                               114.410533,
                               accuracy: 0.00001)
                
                geocoderAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
}

extension InputViewControllerTests {
    // 模拟地理位置
    class MockGeocoder: CLGeocoder {
        // 地理位置操作员
        var completionHandler: CLGeocodeCompletionHandler?
        // 地址字符串
        override func geocodeAddressString(
            _ addressString: String,
            completionHandler: @escaping CLGeocodeCompletionHandler) {
            
            self.completionHandler = completionHandler
        }
    }
    // 模拟地点标签
    class MockPlacemark: CLPlacemark {
        // 模拟2D位置
        var mockCoordinate: CLLocationCoordinate2D?
        // 获取地理位置，如果没有就创建一个
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            
            return CLLocation(latitude: coordinate.latitude,
                              longitude: coordinate.longitude)
        }
    }
}
