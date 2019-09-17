# Chapter 03

## Adding a title property

- ToDoItem.swift
```swift
struct ToDoItem {
    let title: String
}
```

- ToDoItemTests.swift
```swift
func test_Init_TakesTitle() {
    ToDoItem(title: "Foo")
}
```

- 控制台
```
Test Suite 'All tests' started at 2019-09-16 22:51:16.682
Test Suite 'ToDoTests.xctest' started at 2019-09-16 22:51:16.684
Test Suite 'ToDoItemTests' started at 2019-09-16 22:51:16.685
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' passed (0.057 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 22:51:16.744.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.057 (0.059) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 22:51:16.745.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.057 (0.061) seconds
Test Suite 'All tests' passed at 2019-09-16 22:51:16.746.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.057 (0.064) seconds
```

## Rewrite the test method
- ToDoItemTests.swift
```swift
func test_Init_TakesTitle() {
    let item = ToDoItem(title: "Foo")
    XCTAssertNotNil(item, "item should not be nil")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 22:57:35.844
Test Suite 'ToDoTests.xctest' started at 2019-09-16 22:57:35.846
Test Suite 'ToDoItemTests' started at 2019-09-16 22:57:35.846
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' passed (0.060 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 22:57:35.908.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.060 (0.062) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 22:57:35.910.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.060 (0.064) seconds
Test Suite 'All tests' passed at 2019-09-16 22:57:35.911.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.060 (0.067) seconds
```

## Adding an itemDescription property

- ToDoItem.swift
```swift
struct ToDoItem {
    let title: String
    let itemDescription: String?
    
    init(title: String,
         itemDescription: String? = nil) {
        self.title = title
        self.itemDescription = itemDescription
    }
}
```

- ToDoItemTests.swift
```swift
func test_Init_TakesTitleAndDescription() {
    _ = ToDoItem(title: "Foo",
                 itemDescription: "Bar")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 23:01:27.210
Test Suite 'ToDoTests.xctest' started at 2019-09-16 23:01:27.212
Test Suite 'ToDoItemTests' started at 2019-09-16 23:01:27.213
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitle]' passed (0.049 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitleAndDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_TakesTitleAndDescription]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 23:01:27.266.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.051 (0.053) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 23:01:27.268.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.051 (0.056) seconds
Test Suite 'All tests' passed at 2019-09-16 23:01:27.270.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.051 (0.060) seconds
```

## Removing a hidden source of bugs

- ToDoItemTests.swift
```swift
func test_Init_WhenGivenTitle_SetsTitle() {
    let item = ToDoItem(title: "Foo")
    XCTAssertEqual(item.title, "Foo",
                   "should set title")
}

func test_Init_WhenGivenDescription_SetsDescription() {
    let item = ToDoItem(title: "",
                        itemDescription: "Bar")
    XCTAssertEqual(item.itemDescription, "Bar",
                   "should set itemDescription")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 23:08:14.798
Test Suite 'ToDoTests.xctest' started at 2019-09-16 23:08:14.799
Test Suite 'ToDoItemTests' started at 2019-09-16 23:08:14.800
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.031 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 23:08:14.836.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.032 (0.036) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 23:08:14.838.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.032 (0.038) seconds
Test Suite 'All tests' passed at 2019-09-16 23:08:14.839.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.032 (0.041) seconds
```

## Adding a timestamp property

- ToDoItem.swift
```swift
struct ToDoItem {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: Double? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
    }
}
```

- ToDoItemTests.swift
```swift
func test_Init_SetsTimestamp() {
    let item = ToDoItem(title: "",
                        timestamp: 0.0)
    XCTAssertEqual(item.timestamp, 0.0,
                   "should set timestamp")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 23:12:52.341
Test Suite 'ToDoTests.xctest' started at 2019-09-16 23:12:52.343
Test Suite 'ToDoItemTests' started at 2019-09-16 23:12:52.344
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.039 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.002 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 23:12:52.391.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.042 (0.047) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 23:12:52.392.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.042 (0.049) seconds
Test Suite 'All tests' passed at 2019-09-16 23:12:52.393.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.042 (0.052) seconds
```

## Adding a location property

- Location.swift
```swift
struct Location {
    let name: String
}
```

- ToDoItemTests.swift
```swift
func test_Init_WhenGivenLocation_SetsLocation() {
    let location = Location(name: "Foo")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 23:16:04.745
Test Suite 'ToDoTests.xctest' started at 2019-09-16 23:16:04.747
Test Suite 'ToDoItemTests' started at 2019-09-16 23:16:04.747
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.032 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.002 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenLocation_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenLocation_SetsLocation]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 23:16:04.788.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.036 (0.041) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 23:16:04.789.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.036 (0.042) seconds
Test Suite 'All tests' passed at 2019-09-16 23:16:04.791.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.036 (0.046) seconds
```

## Rewrite test 

- ToDoItem.swift
```swift
struct ToDoItem {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: Double? = nil,
         location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}
```

- ToDoItemTests.swift
```swift
func test_Init_SetsLocation() {
    let location = Location(name: "Foo")
    let item = ToDoItem(title: "",
                        location: location)
    XCTAssertEqual(item.location?.name,
                   location.name,
                   "should set location")
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-16 23:21:16.034
Test Suite 'ToDoTests.xctest' started at 2019-09-16 23:21:16.036
Test Suite 'ToDoItemTests' started at 2019-09-16 23:21:16.036
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.080 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.002 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-16 23:21:16.125.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.084 (0.089) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-16 23:21:16.127.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.084 (0.091) seconds
Test Suite 'All tests' passed at 2019-09-16 23:21:16.128.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.084 (0.094) seconds
```


## Adding a coordinate property 新增坐标属性

- Location.swift
```swift
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        self.name = ""
        self.coordinate = coordinate
    }
}
```

- LocationTests.swift
```swift
import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-17 15:04:59.712
Test Suite 'ToDoTests.xctest' started at 2019-09-17 15:04:59.714
Test Suite 'LocationTests' started at 2019-09-17 15:04:59.715
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' passed (0.159 seconds).
Test Suite 'LocationTests' passed at 2019-09-17 15:04:59.877.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.159 (0.162) seconds
Test Suite 'ToDoItemTests' started at 2019-09-17 15:04:59.879
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.004 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-17 15:04:59.890.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.007 (0.012) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-17 15:04:59.891.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.167 (0.177) seconds
Test Suite 'All tests' passed at 2019-09-17 15:04:59.893.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.167 (0.181) seconds
```


## Implementing the ItemManager class

### Count

- ItemManager.swift
```swift
class ItemManager {
    let toDoCount = 0
    let doneCount = 0
}
```

- ItemManagerTests.swift
```swift
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
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-17 15:30:14.850
Test Suite 'ToDoTests.xctest' started at 2019-09-17 15:30:14.853
Test Suite 'ItemManagerTests' started at 2019-09-17 15:30:14.854
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' passed (0.048 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' passed (0.001 seconds).
Test Suite 'ItemManagerTests' passed at 2019-09-17 15:30:14.906.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.050 (0.052) seconds
Test Suite 'LocationTests' started at 2019-09-17 15:30:14.907
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' passed (0.005 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' passed (0.003 seconds).
Test Suite 'LocationTests' passed at 2019-09-17 15:30:14.919.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.008 (0.011) seconds
Test Suite 'ToDoItemTests' started at 2019-09-17 15:30:14.920
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-17 15:30:14.929.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.004 (0.009) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-17 15:30:14.930.
	 Executed 8 tests, with 0 failures (0 unexpected) in 0.062 (0.077) seconds
Test Suite 'All tests' passed at 2019-09-17 15:30:14.931.
	 Executed 8 tests, with 0 failures (0 unexpected) in 0.062 (0.081) seconds
```

### Adding and checking items 添加和判断项目是否相等

- ToDoItem.swift
```swift
struct ToDoItem: Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: Double? = nil,
         location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    // 实现Equatable协议中的方法
    public static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
//        if lhs.location?.name != rhs.location?.name {
//            return false
//        }
        if lhs.location != rhs.location {
            return false
        }
        
        if lhs.timestamp != rhs.timestamp {
            return false
        }
        
        if lhs.itemDescription != rhs.itemDescription {
            return false
        }
        
        if lhs.title != rhs.title {
            return false
        }
        
        return true
    }
    
}
```

- Location.swift
```swift
struct Location: Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    public static func ==(lhs: Location,
                          rhs: Location) -> Bool {
        if lhs.coordinate?.latitude !=
            rhs.coordinate?.latitude {
            return false
        }
        
        if lhs.coordinate?.longitude !=
            rhs.coordinate?.longitude {
            return false
        }
        
        if lhs.name != rhs.name {
            return false
        }
        
        return true
    }
}
```

- ItemManager.swift
```swift
class ItemManager {
//    var toDoCount = 0
//    var doneCount = 0
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    // 新增todo项目
    func add(_ item: ToDoItem) {
        //toDoCount += 1
        toDoItems.append(item)
    }
    
    // 根据序号查找待办项目
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    // 完成项目
    func checkItem(at index: Int) {
        //toDoCount -= 1
        //doneCount += 1
        // _ = toDoItems.remove(at: index)
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        //return ToDoItem(title: "")
        return doneItems[index]
    }
}
```

- ToDoItemTests.swift
```swift
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
```

- LocationTests.swift
```swift
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
```

- ItemManagerTests.swift
```swift
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
    
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-17 17:02:22.933
Test Suite 'ToDoTests.xctest' started at 2019-09-17 17:02:22.935
Test Suite 'ItemManagerTests' started at 2019-09-17 17:02:22.936
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' started.
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' passed (0.160 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' passed (0.004 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' passed (0.003 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' passed (0.001 seconds).
Test Suite 'ItemManagerTests' passed at 2019-09-17 17:02:23.114.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.171 (0.178) seconds
Test Suite 'LocationTests' started at 2019-09-17 17:02:23.116
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' started.
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' passed (0.003 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' passed (0.001 seconds).
Test Suite 'LocationTests' passed at 2019-09-17 17:02:23.132.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.008 (0.016) seconds
Test Suite 'ToDoItemTests' started at 2019-09-17 17:02:23.133
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.002 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-17 17:02:23.154.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.011 (0.021) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-17 17:02:23.155.
	 Executed 23 tests, with 0 failures (0 unexpected) in 0.190 (0.220) seconds
Test Suite 'All tests' passed at 2019-09-17 17:02:23.157.
	 Executed 23 tests, with 0 failures (0 unexpected) in 0.190 (0.224) seconds
```

### Removing all items

- ItemManager.swift
```swift
func removeAll() {
    toDoItems.removeAll()
    doneItems.removeAll()
}
```

- ItemManagerTests.swift
```swift
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
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-17 17:27:53.724
Test Suite 'ToDoTests.xctest' started at 2019-09-17 17:27:53.727
Test Suite 'ItemManagerTests' started at 2019-09-17 17:27:53.728
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' started.
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' passed (0.040 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' passed (0.004 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' passed (0.003 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_RemoveAll_ResultsInCountsBeZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_RemoveAll_ResultsInCountsBeZero]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' passed (0.001 seconds).
Test Suite 'ItemManagerTests' passed at 2019-09-17 17:27:53.787.
	 Executed 8 tests, with 0 failures (0 unexpected) in 0.052 (0.059) seconds
Test Suite 'LocationTests' started at 2019-09-17 17:27:53.788
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' started.
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' passed (0.003 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' passed (0.001 seconds).
Test Suite 'LocationTests' passed at 2019-09-17 17:27:53.803.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.009 (0.015) seconds
Test Suite 'ToDoItemTests' started at 2019-09-17 17:27:53.804
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' passed (0.002 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-17 17:27:53.824.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.010 (0.019) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-17 17:27:53.825.
	 Executed 24 tests, with 0 failures (0 unexpected) in 0.071 (0.098) seconds
Test Suite 'All tests' passed at 2019-09-17 17:27:53.826.
	 Executed 24 tests, with 0 failures (0 unexpected) in 0.071 (0.102) seconds
```

## Ensuring uniqueness 确保对象名称唯一

- ItemManager.swift
```swift
// 新增todo项目
func add(_ item: ToDoItem) {
    //toDoCount += 1
    //toDoItems.append(item)
    if !toDoItems.contains(item) {
        toDoItems.append(item)
    }
}
```

- ItemManagerTests.swift
```swift
func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
    sut.add(ToDoItem(title: "Foo"))
    sut.add(ToDoItem(title: "Foo"))
    XCTAssertEqual(sut.toDoCount, 1)
}
```

- 控制台
```swift
Test Suite 'All tests' started at 2019-09-17 17:33:50.966
Test Suite 'ToDoTests.xctest' started at 2019-09-17 17:33:50.968
Test Suite 'ItemManagerTests' started at 2019-09-17 17:33:50.969
Test Case '-[ToDoTests.ItemManagerTests test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount]' started.
Test Case '-[ToDoTests.ItemManagerTests test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount]' passed (0.162 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' started.
Test Case '-[ToDoTests.ItemManagerTests test_AddItem_IncreasesToDoCountToOne]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_ChangesCounts]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' started.
Test Case '-[ToDoTests.ItemManagerTests test_CheckItemAt_RemovesItFromToDoItems]' passed (0.004 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneCount_Initially_IsZero]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_DoneItemAt_ReturnsCheckedItem]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ItemAt_ReturnsAddedItem]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_RemoveAll_ResultsInCountsBeZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_RemoveAll_ResultsInCountsBeZero]' passed (0.001 seconds).
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' started.
Test Case '-[ToDoTests.ItemManagerTests test_ToDoCount_Initially_IsZero]' passed (0.001 seconds).
Test Suite 'ItemManagerTests' passed at 2019-09-17 17:33:51.153.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.174 (0.184) seconds
Test Suite 'LocationTests' started at 2019-09-17 17:33:51.154
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' started.
Test Case '-[ToDoTests.LocationTests test_EqualLocations_AreEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsCoordinate]' passed (0.003 seconds).
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' started.
Test Case '-[ToDoTests.LocationTests test_Init_SetsName]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLatitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenLongitudeDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenNamesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' started.
Test Case '-[ToDoTests.LocationTests test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual]' passed (0.001 seconds).
Test Suite 'LocationTests' passed at 2019-09-17 17:33:51.172.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.009 (0.018) seconds
Test Suite 'ToDoItemTests' started at 2019-09-17 17:33:51.173
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsLocation]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_SetsTimestamp]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenDescription_SetsDescription]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Init_WhenGivenTitle_SetsTitle]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenDescriptionsDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenLocationDiffers_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenOneLocationIsNil_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTimestampsDiffer_AreNotEqual]' passed (0.001 seconds).
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' started.
Test Case '-[ToDoTests.ToDoItemTests test_Items_WhenTitlesDiffer_AreNotEqual]' passed (0.001 seconds).
Test Suite 'ToDoItemTests' passed at 2019-09-17 17:33:51.196.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.009 (0.023) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-17 17:33:51.197.
	 Executed 25 tests, with 0 failures (0 unexpected) in 0.193 (0.229) seconds
Test Suite 'All tests' passed at 2019-09-17 17:33:51.199.
	 Executed 25 tests, with 0 failures (0 unexpected) in 0.193 (0.233) seconds
```