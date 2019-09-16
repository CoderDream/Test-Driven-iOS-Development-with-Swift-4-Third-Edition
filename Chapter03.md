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


- TODO
```swift

```


- TODO
```swift

```


- TODO
```swift

```


- TODO
```swift

```