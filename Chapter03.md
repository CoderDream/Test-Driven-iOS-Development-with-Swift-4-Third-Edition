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



- TODO
```swift

```