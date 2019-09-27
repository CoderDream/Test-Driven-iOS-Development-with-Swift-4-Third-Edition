# Chapter 05 Testing Network Code

## Implementing tests using a web service

- InputViewControllerTests.swift
```swift
func test_Geocoder_FetchesCoordinates() {
    
    let geocoderAnswered = expectation(description: "Geocoder")
    
    // 由于在中国苹果默认使用高德地图，所以要用中文地址
    let address = "光谷天地"
    CLGeocoder()
        .geocodeAddressString(address) {
            (placemarks, error) -> Void in
            
            let coordinate = placemarks?.first?.location?.coordinate
            guard let latitude =
                coordinate?.latitude else {
                    XCTFail()
                    return
            }
            
            guard let longitude =
                coordinate?.longitude else {
                    XCTFail()
                    return

            XCTAssertEqual(latitude,
                           30.477076,
                           accuracy: 0.00001)
            XCTAssertEqual(longitude,
                           114.410533,
                           accuracy: 0.00001)
            
            geocoderAnswered.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-27 15:03:13.953
Test Suite 'ToDoTests.xctest' started at 2019-09-27 15:03:13.955
Test Suite 'InputViewControllerTests' started at 2019-09-27 15:03:13.956
Test Case '-[ToDoTests.InputViewControllerTests test_Geocoder_FetchesCoordinates]' started.
Test Case '-[ToDoTests.InputViewControllerTests test_Geocoder_FetchesCoordinates]' passed (0.566 seconds).
Test Suite 'InputViewControllerTests' passed at 2019-09-27 15:03:14.524.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.566 (0.569) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-27 15:03:14.526.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.566 (0.571) seconds
Test Suite 'Selected tests' passed at 2019-09-27 15:03:14.527.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.566 (0.575) seconds
```