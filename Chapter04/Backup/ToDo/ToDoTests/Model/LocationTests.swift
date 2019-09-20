//
//  LocationTests.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here.
    }

    override func tearDown() {
        // Put teardown code here. T
    }

    // 通过名称和经纬度初始化位置对象
    func test_Init_SetsCoordinate() {
        let coordinate =
            CLLocationCoordinate2D(latitude: 1,
                                   longitude: 2)
        let location = Location(name: "",
                                coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude,
                       coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude,
                       coordinate.longitude)
    }
    // 通过名称初始化位置对象
    func test_Init_SetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }

    // 测试地址是否相等，当名称相同时相等
    func test_EqualLocations_AreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        XCTAssertEqual(first, second)
    }
    
    // 测试地址是否相等，当经度不同时，不相等
    func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
        let firstCoordinate =
            CLLocationCoordinate2D(latitude: 1.0,
                                   longitude: 0.0)
        let first = Location(name: "Foo",
                             coordinate: firstCoordinate)
        let secondCoordinate =
            CLLocationCoordinate2D(latitude: 0.0,
                                   longitude: 0.0)
        let second = Location(name: "Foo",
                              coordinate: secondCoordinate)
        XCTAssertNotEqual(first, second)
    }
    
    // 测试地址是否相等，当经纬度不同时，不相等
    func test_Locations_WhenLongitudeDiffers_AreNotEqual() {
//        let firstCoordinate =
//            CLLocationCoordinate2D(latitude: 0.0,
//                                   longitude: 1.0)
//        let first = Location(name: "Foo",
//                             coordinate: firstCoordinate)
//        let secondCoordinate =
//            CLLocationCoordinate2D(latitude: 0.0,
//                                   longitude: 0.0)
//        let second = Location(name: "Foo",
//                              coordinate: secondCoordinate)
//        XCTAssertNotEqual(first, second)
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: (1.0, 0.0),
                                   secondName: "Foo",
                                   secondLongLat: (0.0, 0.0))
        
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: (0.0, 1.0),
                                   secondName: "Foo",
                                   secondLongLat: (0.0, 0.0))
    }
    
    // 某个地址只有名称，没有经纬度，两个对象不相等
    func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: (0.0, 0.0),
                                   secondName: "Foo",
                                   secondLongLat: nil)
    }
    
    // 名称不相等
    func test_Locations_WhenNamesDiffer_AreNotEqual() {
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: nil,
                                   secondName: "Bar",
                                   secondLongLat: nil)
    }
    
    // 辅助方法，判断名称和经纬度
    func assertLocationNotEqualWith(firstName: String,
                                    firstLongLat: (Double, Double)?,
                                    secondName: String,
                                    secondLongLat: (Double, Double)?,
                                    line: UInt = #line) {
        var firstCoord: CLLocationCoordinate2D? = nil
        if let firstLongLat = firstLongLat {
            firstCoord =
                CLLocationCoordinate2D(latitude: firstLongLat.0,
                                       longitude: firstLongLat.1)
        }
        let firstLocation =
            Location(name: firstName,
                     coordinate: firstCoord)
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoord =
                CLLocationCoordinate2D(latitude: secondLongLat.0,
                                       longitude: secondLongLat.1)
        }
        let secondLocation =
            Location(name: secondName,
                     coordinate: secondCoord)
        XCTAssertNotEqual(firstLocation, secondLocation)
    }
}
