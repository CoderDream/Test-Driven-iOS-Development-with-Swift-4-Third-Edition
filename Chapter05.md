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


## Handling errors

- APIClient.swift
```swift
// 处理数据任务
session.dataTask(with: url) { (data, response, error) in            
    guard error == nil else {
        return completion(nil, error)
    }
    
    guard let data = data else {
        completion(nil, WebserviceError.DataEmptyError)
        return
    }
    
    do {
        let dict = try JSONSerialization.jsonObject(
            with: data,
            options: []) as? [String:String]
        let token: Token?
        if let tokenString = dict?["token"] {
            token = Token(id: tokenString)
        } else {
            token = nil
        }
        completion(token, nil)
    } catch {
        completion(nil, error)
    }
}.resume()

enum WebserviceError : Error {
    case DataEmptyError
    case ResponseError
}        
```

- APIClientTests.swift
```swift
func test_Login_WhenJSONIsInvalid_ReturnsError() {
        
//        mockURLSession = MockURLSession(data: Data(),
//                                        urlResponse: nil,
//                                        error: nil)
    mockURLSession = MockURLSession(data: nil,
                                    urlResponse: nil,
                                    error: nil)
    
    sut.session = mockURLSession
    let errorExpectation = expectation(description: "Error")
    var catchedError: Error? = nil
    sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
        catchedError = error
        errorExpectation.fulfill()
    }
    waitForExpectations(timeout: 1) { (error) in
        XCTAssertNotNil(catchedError)
    }
}
    
func test_Login_WhenResponseHasError_ReturnsError() {
    let error = NSError(domain: "SomeError",
                        code: 1234,
                        userInfo: nil)
    let jsonData =
        "{\"token\": \"1234567890\"}"
            .data(using: .utf8)
    mockURLSession = MockURLSession(data: jsonData,
                                    urlResponse: nil,
                                    error: error)
    sut.session = mockURLSession
    let errorExpectation = expectation(description: "Error")
    var catchedError: Error? = nil
    sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
        catchedError = error
        errorExpectation.fulfill()
    }
    waitForExpectations(timeout: 1) { (error) in
        XCTAssertNotNil(catchedError)
    }
}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-28 22:06:12.043
Test Suite 'ToDoTests.xctest' started at 2019-09-28 22:06:12.051
Test Suite 'APIClientTests' started at 2019-09-28 22:06:12.054
Test Case '-[ToDoTests.APIClientTests test_Login_WhenJSONIsInvalid_ReturnsError]' started.
https://awesometodos.com/login?username=Foo&password=Bar
Test Case '-[ToDoTests.APIClientTests test_Login_WhenJSONIsInvalid_ReturnsError]' passed (0.174 seconds).
Test Case '-[ToDoTests.APIClientTests test_Login_WhenResponseHasError_ReturnsError]' started.
https://awesometodos.com/login?username=Foo&password=Bar
Test Case '-[ToDoTests.APIClientTests test_Login_WhenResponseHasError_ReturnsError]' passed (0.006 seconds).
Test Suite 'APIClientTests' passed at 2019-09-28 22:06:12.238.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.180 (0.184) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-28 22:06:12.240.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.180 (0.189) seconds
Test Suite 'Selected tests' passed at 2019-09-28 22:06:12.241.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.180 (0.199) seconds
```
