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
2019-09-18 16:31:08.671383+0800 ToDo[27256:2195425] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - 
perhaps the designated entry point is not set?
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

## Implementing ItemListDataProvider 

- ItemListDataProvider.swift
```swift
class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        //return 0
        return itemManager?.toDoCount ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(
        in tableView: UITableView) -> Int {
        return 2
    }
}
```

- ItemListDataProviderTests.swift
```swift
class ItemListDataProviderTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func test_NumberOfSections_IsTwo() {
        let sut = ItemListDataProvider()
        let tableView = UITableView()
        tableView.dataSource = sut
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_Section1_IsToDoCount() {
        let sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        let tableView = UITableView()
        tableView.dataSource = sut
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
}
```

- 控制台
```
2019-09-18 17:01:21.075309+0800 ToDo[27285:2200692] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' 
- perhaps the designated entry point is not set?
Test Suite 'Selected tests' started at 2019-09-18 17:01:21.651
Test Suite 'ToDoTests.xctest' started at 2019-09-18 17:01:21.654
Test Suite 'ItemListDataProviderTests' started at 2019-09-18 17:01:21.654
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' passed (0.109 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' passed (0.003 seconds).
Test Suite 'ItemListDataProviderTests' passed at 2019-09-18 17:01:21.770.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.113 (0.116) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-18 17:01:21.772.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.113 (0.118) seconds
Test Suite 'Selected tests' passed at 2019-09-18 17:01:21.774.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.113 (0.122) seconds
```

## Conducting the first tests

- ItemCell.swift
```swift
import UIKit

class ItemCell: UITableViewCell {

}
```

- ItemListDataProvider.swift
```swift
func tableView(_ tableView: UITableView,
               cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //return UITableViewCell()
    return ItemCell()
}
```

- ItemListDataProviderTests.swift
```swift
func test_CellForRow_ReturnsItemCell() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    tableView.reloadData()
    let cell = tableView.cellForRow(at: IndexPath(row: 0,
                                                  section: 0))
    XCTAssertTrue(cell is ItemCell)
}
```

- 控制台
```
2019-09-18 17:22:44.905778+0800 ToDo[27322:2205809] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - 
perhaps the designated entry point is not set?
Test Suite 'Selected tests' started at 2019-09-18 17:22:45.682
Test Suite 'ToDoTests.xctest' started at 2019-09-18 17:22:45.684
Test Suite 'ItemListDataProviderTests' started at 2019-09-18 17:22:45.685
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' passed (0.660 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' passed (0.002 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' passed (0.001 seconds).
Test Suite 'ItemListDataProviderTests' passed at 2019-09-18 17:22:46.360.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.670 (0.675) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-18 17:22:46.361.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.670 (0.677) seconds
Test Suite 'Selected tests' passed at 2019-09-18 17:22:46.363.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.670 (0.681) seconds
```

