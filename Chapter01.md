
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
/.../FirstDemo/FirstDemoTests/FirstDemoTests.swift:37: Test Case '-[FirstDemoTests.FirstDemoTests testPerformanceExample]' measured [Time, seconds] average: 0.000, relative standard deviation: 73.582%, 
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



- TODO
```swift


```



- TODO
```swift


```




- TODO
```
//    func numberOfVowels(in string: String) -> Int {
//        let vowels: [Character] = ["a", "e", "i", "o", "u",
//                                   "A", "E", "I", "O", "U"]
//
//        return string.characters.reduce(0) {
//            $0 + (vowels.contains($1) ? 1 : 0)
//        }
//    }
    
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


- TODO
```swift


```



