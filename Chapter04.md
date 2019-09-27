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

## DetailViewController

- DetailViewController.swift
```swift
class DetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!            // 标题标签
    @IBOutlet var dateLabel: UILabel!             // 日期标签
    @IBOutlet var locationLabel: UILabel!         // 地点标签
    @IBOutlet var descriptionLabel: UILabel!      // 描述标签
    @IBOutlet var mapView: MKMapView!             // 地图对象
    
    var itemInfo: (ItemManager, Int)?             // 项目信息对象
    
    // 日期格式化对象
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 视图显示到屏幕之前调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 得到项目信息
        guard let itemInfo = itemInfo else { return }
        // 得到第一个项目
        let item = itemInfo.0.item(at: itemInfo.1)
        // 设置视图的标题文本
        titleLabel.text = item.title
        // 设置视图的地点文本
        locationLabel.text = item.location?.name
        // 设置视图的描述文本
        descriptionLabel.text = item.itemDescription
        // 设置视图的时间文本
        if let timestamp = item.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date)
        }
        // 设置视图的地图视图信息
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.region = region
        }
    }
    
    // 完成项目
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItem(at: itemInfo.1)
        }
    }
}
```

- DetailViewControllerTests.swift
```swift
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    // 详情视图控制器
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        // 故事版
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        // 通过故事版创建详情视图控制器对象
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "DetailViewController")
            as? DetailViewController
        // 加载视图控制器
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 判断是否有标题标签
    func test_HasTitleLabel() {
        // 获得标题标签
        let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        // sut.view里包含标签标签
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    // 判断是否有地图视图对象
    func test_HasMapView() {
        // 获得地图视图对象
        let mapViewIsSubView = sut.mapView?.isDescendant(of: sut.view) ?? false
        // sut.view里包含地图视图对象
        XCTAssertTrue(mapViewIsSubView)
    }
    
    // 测试设置事项信息
    func test_SettingItemInfo_SetsTextsToLabels() {
        // 创建地理位置对象
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
        // 创建地点对象，参数为名称和地理位置
        let location = Location(name: "Foo", coordinate: coordinate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: "08/27/2017")
        let timestamp = date?.timeIntervalSince1970
        // 根据标题、描述、时间戳和地点创建事项
        let item = ToDoItem(title: "Bar",
                            itemDescription: "Baz",
                            timestamp: timestamp,
                            location: location)
        // 新建项目管理对象
        let itemManager = ItemManager()
        // 添加项目
        itemManager.add(item)
        // 设置视图控制器的项目信息
        sut.itemInfo = (itemManager, 0)
        // 开始转场
        sut.beginAppearanceTransition(true, animated: true)
        // 结束转场
        sut.endAppearanceTransition()
        // 判断标题文本是否相等
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        // 判断日期文本是否相等
        XCTAssertEqual(sut.dateLabel.text, "08/27/2017")
        // 判断地点文本是否相等
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        // 判断描述文本是否相等
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        // 判断精度信息是否相等
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       coordinate.latitude,
                       accuracy: 0.001)
        // 判断维度信息是否相等
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       coordinate.longitude,
                       accuracy: 0.001)
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        // 新建项目管理对象
        let itemManager = ItemManager()
        // 添加匿名项目对象
        itemManager.add(ToDoItem(title: "Foo"))
        // 设置视图控制器的项目信息
        sut.itemInfo = (itemManager, 0)
        // 完成项目
        sut.checkItem()
        // 判断待办数目是否为0
        XCTAssertEqual(itemManager.toDoCount, 0)
        // 判断待办数目是否为1
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-27 10:46:24.699
Test Suite 'ToDoTests.xctest' started at 2019-09-27 10:46:24.701
Test Suite 'DetailViewControllerTests' started at 2019-09-27 10:46:24.702
Test Case '-[ToDoTests.DetailViewControllerTests test_CheckItem_ChecksItemInItemManager]' started.
Test Case '-[ToDoTests.DetailViewControllerTests test_CheckItem_ChecksItemInItemManager]' passed (1.658 seconds).
Test Case '-[ToDoTests.DetailViewControllerTests test_HasMapView]' started.
Test Case '-[ToDoTests.DetailViewControllerTests test_HasMapView]' passed (0.017 seconds).
Test Case '-[ToDoTests.DetailViewControllerTests test_HasTitleLabel]' started.
Test Case '-[ToDoTests.DetailViewControllerTests test_HasTitleLabel]' passed (0.013 seconds).
Test Case '-[ToDoTests.DetailViewControllerTests test_SettingItemInfo_SetsTextsToLabels]' started.
Test Case '-[ToDoTests.DetailViewControllerTests test_SettingItemInfo_SetsTextsToLabels]' passed (0.039 seconds).
Test Suite 'DetailViewControllerTests' passed at 2019-09-27 10:46:26.434.
	 Executed 4 tests, with 0 failures (0 unexpected) in 1.726 (1.733) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-27 10:46:26.436.
	 Executed 4 tests, with 0 failures (0 unexpected) in 1.726 (1.735) seconds
Test Suite 'Selected tests' passed at 2019-09-27 10:46:26.437.
	 Executed 4 tests, with 0 failures (0 unexpected) in 1.726 (1.739) seconds
```

## InputViewController

- InputViewController.swift
```swift
import CoreLocation

class InputViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!              // 标题输入框
    @IBOutlet var dateTextField: UITextField!               // 日期输入框
    @IBOutlet var locationTextField: UITextField!           // 地点输入框
    @IBOutlet var addressTextField: UITextField!            // 地址输入框
    @IBOutlet var descriptionTextField: UITextField!        // 描述输入框
    @IBOutlet var saveButton: UIButton!                     // 保存按钮
    
    lazy var geocoder = CLGeocoder()                        // 地理位置对象
    var itemManager: ItemManager?                           // 项目管理器
    // 日期格式化器
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 保存方法
    @IBAction func save() {
        // 获取标题输入框的内容字符串
        guard let titleString = titleTextField.text,
            titleString.count > 0 else { return }
        // 获取日期文本并转换成日期类型的对象
        let date: Date?
        if let dateText = self.dateTextField.text,
            dateText.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        // 获取描述输入框的内容字符串
        let descriptionString = descriptionTextField.text
        // 获取地点输入框的内容字符串，如果有地点信息，继续
        if let locationName = locationTextField.text,
            locationName.count > 0 {
            // 如果有地址信息
            if let address = addressTextField.text,
                address.count > 0 {
                // 通过地址反解析地理位置
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    // 得到第一个地点标签
                    let placeMark = placeMarks?.first
                    // 打印
                    print("timestamp: \(String(describing: date?.timeIntervalSince1970))")
                    // 根据标题、描述、日期和地点信息创建事项对象
                    let item = ToDoItem(
                        title: titleString,
                        itemDescription: descriptionString,
                        timestamp: date?.timeIntervalSince1970,
                        location: Location(
                            name: locationName,
                            coordinate: placeMark?.location?.coordinate))
                    // 添加事项对象
                    self.itemManager?.add(item)
                }
            }
        }
    }
}
```


- InputViewControllerTests.swift
```swift
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
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-27 11:28:52.804
Test Suite 'ToDoTests.xctest' started at 2019-09-27 11:28:52.807
Test Suite 'InputViewControllerTests' started at 2019-09-27 11:28:52.808
Test Case '-[ToDoTests.InputViewControllerTests test_HasTitleTextField]' started.
Test Case '-[ToDoTests.InputViewControllerTests test_HasTitleTextField]' passed (0.223 seconds).
Test Case '-[ToDoTests.InputViewControllerTests test_Save_UsesGeocoderToGetCoordinateFromAddress]' started.
timestamp: Optional(1456070400.0)
Test Case '-[ToDoTests.InputViewControllerTests test_Save_UsesGeocoderToGetCoordinateFromAddress]' passed (0.064 seconds).
Test Case '-[ToDoTests.InputViewControllerTests test_SaveButtonHasSaveAction]' started.
Test Case '-[ToDoTests.InputViewControllerTests test_SaveButtonHasSaveAction]' passed (0.015 seconds).
Test Suite 'InputViewControllerTests' passed at 2019-09-27 11:28:53.114.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.301 (0.306) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-27 11:28:53.116.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.301 (0.308) seconds
Test Suite 'Selected tests' passed at 2019-09-27 11:28:53.117.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.301 (0.313) seconds
```