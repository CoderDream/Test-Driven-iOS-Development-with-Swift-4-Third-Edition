# 6 Putting It All Together

## The initial view controller

- StoryboardTests.swift
```swift
import XCTest
@testable import ToDo

class StoryboardTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func test_InitialViewController_IsItemListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController =
            storyboard.instantiateInitialViewController()
                as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is ItemListViewController)
    }

}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-10-08 10:40:39.807
Test Suite 'ToDoTests.xctest' started at 2019-10-08 10:40:39.809
Test Suite 'StoryboardTests' started at 2019-10-08 10:40:39.810
Test Case '-[ToDoTests.StoryboardTests test_InitialViewController_IsItemListViewController]' started.
Test Case '-[ToDoTests.StoryboardTests test_InitialViewController_IsItemListViewController]' passed (0.049 seconds).
Test Suite 'StoryboardTests' passed at 2019-10-08 10:40:39.862.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.049 (0.052) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-10-08 10:40:39.863.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.049 (0.054) seconds
Test Suite 'Selected tests' passed at 2019-10-08 10:40:39.864.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.049 (0.058) seconds
```