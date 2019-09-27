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

## Register ItemCell Manual

手工注册UITableViewCell，在视图中新增了对象，然后设置了Class和Identitifer，但是不起作用，还是要做视图中注册。

- ItemCell.swift
```swift
class ItemCell: UITableViewCell {
    func configCell(with item: ToDoItem) {
    }
}
```

- ItemListViewController.swift
```swift
class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        // Do any additional setup after loading the view.
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        // 手工注册UITableViewCell
        self.tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
    }

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
    
func test_CellForRow_DequeuesCellFromTableView() {
    let mockTableView = MockTableView()
    mockTableView.dataSource = sut
    mockTableView.register(ItemCell.self,
                           forCellReuseIdentifier: "ItemCell")
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    mockTableView.reloadData()
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertTrue(mockTableView.cellGotDequeued)
}
    
func test_CellForRow_CallsConfigCell() {
    let mockTableView = MockTableView()
    mockTableView.dataSource = sut
    mockTableView.register(
        MockItemCell.self,
        forCellReuseIdentifier: "ItemCell")
    let item = ToDoItem(title: "Foo")
    sut.itemManager?.add(item)
    mockTableView.reloadData()
    let cell = mockTableView
        .cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
    XCTAssertTrue(cell.configCellGotCalled)
}

// 辅助类
class MockItemCell : ItemCell {
    var configCellGotCalled = false
    override func configCell(with item: ToDoItem) {
        configCellGotCalled = true
    }
}
```

- 控制台
```
Test Suite 'Selected tests' started at 2019-09-19 17:09:46.823
Test Suite 'ToDoTests.xctest' started at 2019-09-19 17:09:46.825
Test Suite 'ItemListDataProviderTests' started at 2019-09-19 17:09:46.826
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_CallsConfigCell]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_CallsConfigCell]' passed (0.182 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_DequeuesCellFromTableView]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_DequeuesCellFromTableView]' passed (0.008 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' passed (0.006 seconds).
Test Suite 'ItemListDataProviderTests' passed at 2019-09-19 17:09:47.047.
	 Executed 6 tests, with 0 failures (0 unexpected) in 0.215 (0.222) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-19 17:09:47.049.
	 Executed 6 tests, with 0 failures (0 unexpected) in 0.215 (0.224) seconds
Test Suite 'Selected tests' passed at 2019-09-19 17:09:47.050.
	 Executed 6 tests, with 0 failures (0 unexpected) in 0.215 (0.228) seconds
```

## Delete button


- ItemListDataProvider.swift
```swift
func tableView(
    _ tableView: UITableView,
    titleForDeleteConfirmationButtonForRowAt indexPath:
    IndexPath) -> String? {
    guard let section = Section(rawValue: indexPath.section) else {
        fatalError()
    }
    let buttonTitle: String
    switch section {
    case .toDo:
        buttonTitle = "Check"
    case .done:
        buttonTitle = "Uncheck"
    }
    return buttonTitle
    //return "Check"
}
```

- ItemListDataProviderTests.swift
```swift
func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(
        tableView,
        titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                            section: 0))
    XCTAssertEqual(deleteButtonTitle, "Check")
}
    
func test_DeleteButton_InSecondSection_ShowsTitleUncheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(
        tableView,
        titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                            section: 1))
    XCTAssertEqual(deleteButtonTitle, "Uncheck")
}
```

- 控制台
```
Test Suite 'Selected tests' started at 2019-09-19 17:34:15.947
Test Suite 'ToDoTests.xctest' started at 2019-09-19 17:34:15.950
Test Suite 'ItemListDataProviderTests' started at 2019-09-19 17:34:15.953
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_CallsConfigCell]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_CallsConfigCell]' passed (0.142 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_DequeuesCellFromTableView]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_DequeuesCellFromTableView]' passed (0.013 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell]' passed (0.011 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_Section2_CallsConfigCellWithDoneItem]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_CellForRow_Section2_CallsConfigCellWithDoneItem]' passed (0.009 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_DeleteButton_InFirstSection_ShowsTitleCheck]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_DeleteButton_InFirstSection_ShowsTitleCheck]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_DeleteButton_InSecondSection_ShowsTitleUncheck]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_DeleteButton_InSecondSection_ShowsTitleUncheck]' passed (0.005 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section1_IsToDoCount]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfRows_Section2_IsToDoneCount]' passed (0.005 seconds).
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' started.
Test Case '-[ToDoTests.ItemListDataProviderTests test_NumberOfSections_IsTwo]' passed (0.006 seconds).
Test Suite 'ItemListDataProviderTests' passed at 2019-09-19 17:34:16.173.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.206 (0.220) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-19 17:34:16.174.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.206 (0.224) seconds
Test Suite 'Selected tests' passed at 2019-09-19 17:34:16.175.
	 Executed 9 tests, with 0 failures (0 unexpected) in 0.206 (0.228) seconds
```

## Versions

1. V0.4 使用书中第4章代码里面的main文件；


[ToDoTests.ItemListDataProviderTests test_CellForRow_ReturnsItemCell] : failed: 
caught "NSInternalInconsistencyException", 
"unable to dequeue a cell with identifier ItemCell - 
must register a nib or a class for the identifier or connect a prototype cell in a storyboard"


## ItemCell

- ItemCell.swift
```swift
class ItemCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!      // 标题
    @IBOutlet var locationLabel: UILabel!   // 地点
    @IBOutlet var dateLabel: UILabel!       // 日期
    
    // 日期格式化对象
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 设置对象
    func configCell(with item: ToDoItem,
                    checked: Bool = false) {
        // 如果已检查（完成）
        if checked {
            // 通过title创建属性字符串
            let attributedString = NSAttributedString(
                string: item.title,
                attributes: [NSAttributedString.Key.strikethroughStyle:
                    NSUnderlineStyle.single.rawValue])
            // 设置属性文本属性
            titleLabel.attributedText = attributedString
            // 重置地点标签内容
            locationLabel.text = nil
            // 重置日期标签内容
            dateLabel.text = nil
        }
        // 没有完成
        else {
            // 设置标题文本
            titleLabel.text = item.title
            // 设置地点文本
            locationLabel.text = item.location?.name ?? ""
            // 设置日期文本
            if let timestamp = item.timestamp {
                // 根据对象的时间戳新建日期对象
                let date = Date(timeIntervalSince1970: timestamp)
                // 格式化日期后设置日期标签文本
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
}
```

- ItemCellTests.swift
```swift
class ItemCellTests: XCTestCase {
    // 表格视图属性
    var tableView: UITableView!
    // 数据源属性（内置伪数据源）
    let dataSource = FakeDataSource()
    // 表格的单元格
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        // 面板
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 通过面板实例化控制器对象
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "ItemListViewController")
            as! ItemListViewController
        // 加载控制器对象（生成控制器中的表格视图对象属性）
        controller.loadViewIfNeeded()
        // 设置表格视图属性
        tableView = controller.tableView
        // 设置数据源
        tableView?.dataSource = dataSource
        // 获取第1章节的第1个表格单元格
        cell = tableView?.dequeueReusableCell(
            withIdentifier: "ItemCell",
            for: IndexPath(row: 0, section: 0)) as? ItemCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 测试是否有名称标签
    func test_HasNameLabel() {
        //print(cell.titleLabel)
        // 非空判断
        XCTAssertNotNil(cell.titleLabel)
        // 判断titleLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasLocationLabel() {
        // 判断locationLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasDateLabel() {
        // 判断dateLabel对象是否为cell.contenView 的子类（是否挂在contentView下面）
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ConfigCell_SetsTitle() {
        // 设置标题
        cell.configCell(with: ToDoItem(title: "Foo"))
        // 判断标题是否设置成功
        XCTAssertEqual(cell.titleLabel.text, "Foo")
    }
    
    func test_ConfigCell_SetsDate() {
        // 创建内置的日期格式化对象
        let dateFormatter = DateFormatter()
        // 设置日期格式
        dateFormatter.dateFormat = "MM/dd/yyyy"
        // 通过日期格式化对象创建日期对象
        let date = dateFormatter.date(from: "08/27/2017")
        // 创建时间戳对象
        let timestamp = date?.timeIntervalSince1970
        // 通过标题和时间戳设置cell
        cell.configCell(with: ToDoItem(title: "Foo",
                                       timestamp: timestamp))
        // 判断时间戳是否设置成功
        XCTAssertEqual(cell.dateLabel.text, "08/27/2017")
    }
    
    // 测试设置地点名称
    func test_ConfigCell_SetsLocation() {
        // 通过名称创建地点对象
        let location = Location(name: "Bar")
        // 通过标题和地点设置cell
        cell.configCell(with: ToDoItem(title: "Foo",
                                       location: location))
        // 判断地点是否设置成功
        XCTAssertEqual(cell.locationLabel.text, "Bar")
    }
    
    func test_Title_WhenItemIsChecked_IsStrokeThrough() {
        // 通过名称创建地点对象
        let location = Location(name: "Bar")
        // 通过标题、描述、时间戳和地点创建事项对象
        let item = ToDoItem(title: "Foo",
                            itemDescription: nil,
                            timestamp: 0,
                            location: location)
        // 通过事项对象和是否已检查设置单元格
        cell.configCell(with: item, checked: true)
        // 创建属性字符串
        let attributedString = NSAttributedString(
            string: "Foo",
            attributes: [NSAttributedStringKey.strikethroughStyle:
                NSUnderlineStyle.styleSingle.rawValue])
        // 判断属性字符串是否正确
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        // 判断地点标签对象是否不为空
        XCTAssertNil(cell.locationLabel.text)
        // 判断日期标签对象是否不为空
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    // 伪数据源
    class FakeDataSource: NSObject, UITableViewDataSource {
        // 设置章节数量
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        // 设置返回的单元格对象
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
                return UITableViewCell()
        }
    }
}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-27 10:08:18.852
Test Suite 'ToDoTests.xctest' started at 2019-09-27 10:08:18.855
Test Suite 'ItemCellTests' started at 2019-09-27 10:08:18.856
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsDate]' started.
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsDate]' passed (0.161 seconds).
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsLocation]' started.
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsLocation]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsTitle]' started.
Test Case '-[ToDoTests.ItemCellTests test_ConfigCell_SetsTitle]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemCellTests test_HasDateLabel]' started.
Test Case '-[ToDoTests.ItemCellTests test_HasDateLabel]' passed (0.007 seconds).
Test Case '-[ToDoTests.ItemCellTests test_HasLocationLabel]' started.
Test Case '-[ToDoTests.ItemCellTests test_HasLocationLabel]' passed (0.006 seconds).
Test Case '-[ToDoTests.ItemCellTests test_HasNameLabel]' started.
Test Case '-[ToDoTests.ItemCellTests test_HasNameLabel]' passed (0.015 seconds).
Test Case '-[ToDoTests.ItemCellTests test_Title_WhenItemIsChecked_IsStrokeThrough]' started.
Test Case '-[ToDoTests.ItemCellTests test_Title_WhenItemIsChecked_IsStrokeThrough]' passed (0.014 seconds).
Test Suite 'ItemCellTests' passed at 2019-09-27 10:08:19.081.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.218 (0.226) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-27 10:08:19.083.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.218 (0.228) seconds
Test Suite 'Selected tests' passed at 2019-09-27 10:08:19.085.
	 Executed 7 tests, with 0 failures (0 unexpected) in 0.218 (0.233) seconds
```