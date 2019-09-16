
# Chapter01



- Fix problem:  
	- Swift version from 5.0 to 4.2
	- Target from 12.2 to 12.1 


- Running Unit Test:  
	- Menu: Product - Test
	- Keys: Command + U

- Console output:   
```
Test Suite 'Selected tests' started at 2019-09-07 16:41:01.185
Test Suite 'FirstDemoTests.xctest' started at 2019-09-07 16:41:01.187
Test Suite 'FirstDemoTests' started at 2019-09-07 16:41:01.188
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.047 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/../Chapter01/FirstDemo/FirstDemoTests/FirstDemoTests.swift:37: 
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' measured [Time, seconds] 
average: 0.000, relative standard deviation: 76.181%, 
values: [0.000005, 0.000002, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , 
maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.493 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-07 16:41:01.733.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.541 (0.545) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-07 16:41:01.735.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.541 (0.548) seconds
Test Suite 'Selected tests' passed at 2019-09-07 16:41:01.736.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.541 (0.551) seconds

```

## Implementing a unit test example

- numberOfVowels(_:) 元音字母的个数
```swift
func numberOfVowels(in string: String) -> Int {
    let vowels: [Character] = ["a", "e", "i", "o", "u",
                               "A", "E", "I", "O", "U"]
    var numberOfVowels = 0
    for character in string {
        if vowels.contains(character) {
            numberOfVowels += 1
        }
    }
    return numberOfVowels
}
```

- 测试方法
```swift
func test_NumberOfVowels_WhenPassedDominik_ReturnsThree() {
    let viewController = ViewController()
    let string = "Dominik"
    let numberOfVowels = viewController.numberOfVowels(in: string)
    XCTAssertEqual(numberOfVowels, 3,
                   "should find 3 vowels in Dominik")
}
```

通过菜单【Project】-》【Test】或者快捷键【Command+U】执行测试用例：

- 控制台输出结果
```swift
Test Suite 'All tests' started at 2019-09-15 17:45:29.995
Test Suite 'FirstDemoTests.xctest' started at 2019-09-15 17:45:29.997
Test Suite 'FirstDemoTests' started at 2019-09-15 17:45:29.998
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.091 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:37: 
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' measured [Time, seconds] average: 0.000, 
relative standard deviation: 73.582%, 
values: [0.000005, 0.000003, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "", baselineAverage: , 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.494 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-15 17:45:30.588.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.586 (0.590) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-15 17:45:30.589.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.586 (0.591) seconds
Test Suite 'All tests' passed at 2019-09-15 17:45:30.590.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.586 (0.595) seconds
```



- 把3修改为4，失败：
```swift
XCTAssertEqual(numberOfVowels, 4,
                       "should find 4 vowels in Dominik")

XCTAssertEqual failed: ("3") is not equal to ("4") - should find 4 vowels in Dominik
```

- 控制台的出错信息：
```swift
Test Suite 'All tests' started at 2019-09-15 19:44:47.130
Test Suite 'FirstDemoTests.xctest' started at 2019-09-15 19:44:47.138
Test Suite 'FirstDemoTests' started at 2019-09-15 19:44:47.139
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:31: 
error: -[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree] : 
XCTAssertEqual failed: ("3") is not equal to ("4") - should find 4 vowels in Dominik
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' failed (0.106 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.002 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:37: 
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' measured [Time, seconds] average: 0.000, 
relative standard deviation: 75.297%, 
values: [0.000004, 0.000002, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "", 
baselineAverage: , 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.483 seconds).
Test Suite 'FirstDemoTests' failed at 2019-09-15 19:44:47.736.
	 Executed 3 tests, with 1 failure (0 unexpected) in 0.591 (0.597) seconds
Test Suite 'FirstDemoTests.xctest' failed at 2019-09-15 19:44:47.737.
	 Executed 3 tests, with 1 failure (0 unexpected) in 0.591 (0.599) seconds
Test Suite 'All tests' failed at 2019-09-15 19:44:47.742.
	 Executed 3 tests, with 1 failure (0 unexpected) in 0.591 (0.612) seconds
```



## Green - example 1
- ViewController中的方法
```swift
func makeHeadline(from string: String) -> String {
    return "This Is A Test Headline"
}
```

- 测试方法
```swift
func test_MakeHeadline_ReturnsStringWithEachWordStartCapital() {
    let viewController = ViewController()
    let string = "this is A test headline"
    let headline = viewController.makeHeadline(from: string)
    XCTAssertEqual(headline, "This Is A Test Headline")
}
```

- 测试结果
```swift
Test Suite 'All tests' started at 2019-09-15 21:46:18.945
Test Suite 'FirstDemoTests.xctest' started at 2019-09-15 21:46:18.947
Test Suite 'FirstDemoTests' started at 2019-09-15 21:46:18.948
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' passed (0.038 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.013 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:44: Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' 
measured [Time, seconds] average: 0.000, 
relative standard deviation: 64.061%, 
values: [0.000012, 0.000008, 0.000004, 0.000003, 0.000003, 0.000003, 0.000003, 0.000003, 0.000003, 0.000003], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "Local Baseline", 
baselineAverage: 0.000, 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.549 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-15 21:46:19.555.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.601 (0.607) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-15 21:46:19.560.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.601 (0.613) seconds
Test Suite 'All tests' passed at 2019-09-15 21:46:19.565.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.601 (0.620) seconds
```

## Refactor - example 1

重构，把视图控制器作为变量抽取出来，然后在setUp方法里初始化，然后去掉每个测试方法中的视图控制器变量。

- FirstDemoTests
```swift
var viewController: ViewController!

override func setUp() {
    super.setUp()
    viewController = ViewController()
}
```

- 执行结果，控制台：
```
Test Suite 'All tests' started at 2019-09-15 22:28:42.582
Test Suite 'FirstDemoTests.xctest' started at 2019-09-15 22:28:42.584
Test Suite 'FirstDemoTests' started at 2019-09-15 22:28:42.585
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' passed (0.061 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.012 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.002 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:46: 
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' 
measured [Time, seconds] average: 0.000, 
relative standard deviation: 123.310%, 
values: [0.000013, 0.000004, 0.000002, 0.000002, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "Local Baseline", 
baselineAverage: 0.000, 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.570 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-15 22:28:43.235.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.644 (0.649) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-15 22:28:43.236.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.644 (0.652) seconds
Test Suite 'All tests' passed at 2019-09-15 22:28:43.237.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.644 (0.655) seconds
```

## Green - example 2

增加新方法

- FirstDemoTests
```
func test_MakeHeadline_ReturnsStringWithEachWordStartCapital2() {
    let string = "Here is another Example"
    let headline = viewController.makeHeadline(from: string)
    XCTAssertEqual(headline, "Here Is Another Example")
}
```


- ViewController
```swift
func makeHeadline(from string: String) -> String {
    let words = string.components(separatedBy: " ")
    var headline = ""
    for var word in words {
        let firstCharacter = word.remove(at: word.startIndex)
        headline += "\(String(firstCharacter).uppercased())\(word) "
    }
    headline.remove(at: headline.index(before: headline.endIndex))
    return headline
}
```

- 运行结果
```
Test Suite 'All tests' started at 2019-09-16 21:07:29.011
Test Suite 'FirstDemoTests.xctest' started at 2019-09-16 21:07:29.013
Test Suite 'FirstDemoTests' started at 2019-09-16 21:07:29.014
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' passed (0.191 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital2]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital2]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.002 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:52: Test Case '-
[FirstDemoTests.FirstDemoTests testPerformanceExample]' measured [Time, seconds] average: 0.000, 
relative standard deviation: 73.646%, 
values: [0.000004, 0.000003, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "Local Baseline", 
baselineAverage: 0.000, 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.509 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-16 21:07:29.722.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.703 (0.708) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-16 21:07:29.723.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.703 (0.710) seconds
Test Suite 'All tests' passed at 2019-09-16 21:07:29.724.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.703 (0.713) seconds
```


## Refactor - example 2

- FirstDemoTests
```
func test_MakeHeadline_ReturnsStringWithEachWordStartCapital() {
    let input = "this is A test headline"
    let expectedOutput = "This Is A Test Headline"
    let headline = viewController.makeHeadline(from: input)
    XCTAssertEqual(headline, expectedOutput)
}
    
func test_MakeHeadline_ReturnsStringWithEachWordStartCapital2() {
    let input = "Here is another Example"
    let expectedOutput = "Here Is Another Example"
    let headline = viewController.makeHeadline(from: input)
    XCTAssertEqual(headline, expectedOutput)
}
```


- ViewController
```
func makeHeadline(from string: String) -> String {
    let words = string.components(separatedBy: " ")
    let headlineWords = words.map { (word) -> String in
        var mutableWord = word
        let first = mutableWord.remove(at: mutableWord.startIndex)
        return String(first).uppercased() + mutableWord
    }
    return headlineWords.joined(separator: " ")
}
```

- 控制台输出
```swift
Test Suite 'All tests' started at 2019-09-16 21:57:14.418
Test Suite 'FirstDemoTests.xctest' started at 2019-09-16 21:57:14.420
Test Suite 'FirstDemoTests' started at 2019-09-16 21:57:14.421
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital]' passed (0.070 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital2]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_MakeHeadline_ReturnsStringWithEachWordStartCapital2]' passed (0.002 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' started.
Test Case '-[FirstDemoTests.FirstDemoTests test_NumberOfVowels_WhenPassedDominik_ReturnsThree]' passed (0.005 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' started.
Test Case '-[FirstDemoTests.FirstDemoTests testExample]' passed (0.001 seconds).
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' started.
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:54: Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' 
measured [Time, seconds] average: 0.000, 
relative standard deviation: 77.080%, 
values: [0.000004, 0.000003, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.000001], 
performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, 
baselineName: "Local Baseline", 
baselineAverage: 0.000, 
maxPercentRegression: 10.000%, 
maxPercentRelativeStandardDeviation: 10.000%, 
maxRegression: 0.100, 
maxStandardDeviation: 0.100
Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' passed (0.410 seconds).
Test Suite 'FirstDemoTests' passed at 2019-09-16 21:57:14.914.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.487 (0.493) seconds
Test Suite 'FirstDemoTests.xctest' passed at 2019-09-16 21:57:14.915.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.487 (0.495) seconds
Test Suite 'All tests' passed at 2019-09-16 21:57:14.916.
	 Executed 5 tests, with 0 failures (0 unexpected) in 0.487 (0.498) seconds
```



