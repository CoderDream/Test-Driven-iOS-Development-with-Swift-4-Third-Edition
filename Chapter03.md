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

## Adding an timestamp property

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


- TODO
```swift

```