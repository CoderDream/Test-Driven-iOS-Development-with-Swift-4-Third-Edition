
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