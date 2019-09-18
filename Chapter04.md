# Chapter 04 A Test-Driven View Controller

## Implementing ItemListViewController 

- ItemListViewController.swift
```swift
import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        // Do any additional setup after loading the view.
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }

}
```

- ItemListDataProvider.swift
```swift
import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
```

- ItemListViewControllerTest.swift
```swift
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

    func test_TableViewIsNotNilAfterViewDidLoad() {
        //let sut = ItemListViewController()
        //sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(
            sut.tableView.dataSource as? ItemListDataProvider,
            sut.tableView.delegate as? ItemListDataProvider)
    }
}
```

运行测试之前，先设置：【Product】-》【Scheme】-》【Edit Scheme】，选择【Test】，然后设置 tests，把不需要执行的测试文件的勾选☑️去掉。

- 控制台
```
2019-09-18 16:31:08.671383+0800 ToDo[27256:2195425] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set?
Test Suite 'Selected tests' started at 2019-09-18 16:31:08.816
Test Suite 'ToDoTests.xctest' started at 2019-09-18 16:31:08.817
Test Suite 'ItemListViewControllerTest' started at 2019-09-18 16:31:08.818
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_DataSourceEqualDelegate]' started.
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_DataSourceEqualDelegate]' passed (0.052 seconds).
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_SetsTableViewDataSource]' started.
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_SetsTableViewDataSource]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_SetsTableViewDelegate]' started.
Test Case '-[ToDoTests.ItemListViewControllerTest test_LoadingView_SetsTableViewDelegate]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemListViewControllerTest test_TableView_AfterViewDidLoad_IsNotNil]' started.
Test Case '-[ToDoTests.ItemListViewControllerTest test_TableView_AfterViewDidLoad_IsNotNil]' passed (0.012 seconds).
Test Case '-[ToDoTests.ItemListViewControllerTest test_TableViewIsNotNilAfterViewDidLoad]' started.
Test Case '-[ToDoTests.ItemListViewControllerTest test_TableViewIsNotNilAfterViewDidLoad]' passed (0.007 seconds).
Test Suite 'ItemListViewControllerTest' passed at 2019-09-18 16:31:08.909.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.084 (0.090) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-18 16:31:08.910.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.084 (0.093) seconds
Test Suite 'Selected tests' passed at 2019-09-18 16:31:08.912.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.084 (0.096) seconds
```