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


## Implementing a login request


- APIClient.swift
```swift
import Foundation

class APIClient {
    lazy var session: SessionProtocol = URLSession.shared
    
    func loginUser(withName username: String,
                   password: String,
                   completion: @escaping (Token?, Error?) -> Void) {
//        guard let url = URL(string: "https://awesometodos.com") else {
//            fatalError()
//        }
        
//        guard let url = URL(string: "https://awesometodos.com/login") else {
//            fatalError()
//        }
        
//        let query = "username=\(username)&password=\(password)"
//        guard let url = URL(string:
//            "https://awesometodos.com/login?\(query)") else {
//                fatalError()
//        }
        
//        let allowedCharacters = CharacterSet(
//            charactersIn:
//            "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
//        guard let encodedUsername = username.addingPercentEncoding(
//            withAllowedCharacters: allowedCharacters) else { fatalError() }
//        guard let encodedPassword = password.addingPercentEncoding(
//            withAllowedCharacters: allowedCharacters) else { fatalError() }
//        let query = "username=\(encodedUsername)&password=\(encodedPassword)"
//        guard let url = URL(string:
//            "https://awesometodos.com/login?\(query)") else {
//                fatalError()
//        }
        // 查询条件，包含用户名和密码（已编码）
        let query = "username=\(username.percentEncoded)&password=\(password.percentEncoded)"
        // 创建 url 对象
        guard let url = URL(string:
            "https://awesometodos.com/login?\(query)") else {
                fatalError()
        }
        
//        session.dataTask(with: url) { (data, response, error) in
//        }
        // 处理数据任务
        session.dataTask(with: url) { (data, response, error) in
            // 如果数据为空，直接返回
            guard let data = data else { return }
            // 生成字典
            let dict = try! JSONSerialization.jsonObject(
                with: data,
                options: []) as? [String:String]
            // 生成 token 对象
            let token: Token?
            if let tokenString = dict?["token"] {
                token = Token(id: tokenString)
            } else {
                token = nil
            }
            completion(token, nil)
        }.resume()
    }
}

// 缓存协议
protocol SessionProtocol {
    // 数据任务接口方法
    func dataTask(
        with url: URL,
        completionHandler: @escaping
        (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTask
}

// 让 URLSession 实现 缓存协议
extension URLSession: SessionProtocol {
    
}

// 扩展 String，让字符串处理特殊字符
extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(
            charactersIn:
            "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encoded = self.addingPercentEncoding(
            withAllowedCharacters: allowedCharacters) else { fatalError() }
        return encoded
    }
}

```

- APIClientTests.swift
```swift
class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUp() {
        sut = APIClient()
        //mockURLSession = MockURLSession()
        mockURLSession =
            MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
    }

    override func tearDown() {
    }
    
    // 测试host
    func test_Login_UsesExpectedHost() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName:"dasdom",
                      password: "1234",
                      completion: completion)
        //guard let url = mockURLSession.url else { XCTFail(); return }
        //let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        XCTAssertEqual(
            mockURLSession.urlComponents?.host,
            "awesometodos.com")
    }
    
    // 测试访问路径
    func test_Login_UsesExpectedPath() {
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName:"dasdom",
                      password: "1234",
                      completion: completion)
        //guard let url = mockURLSession.url else { XCTFail(); return }
        //let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        //XCTAssertEqual(urlComponents?.path, "/login")
        XCTAssertEqual(
            mockURLSession.urlComponents?.path,
            "/login")
    }
    
    // 测试带参数的访问
    func test_Login_UsesExpectedQuery() {
        let completion = { (token: Token?, error: Error?) in }
//        sut.loginUser(withName:"dasdom",
//                      password: "1234",
//                      completion: completion)
        sut.loginUser(withName:"dasdöm",
                      password: "%&34",
                      completion: completion)
//        XCTAssertEqual(
//            mockURLSession.urlComponents?.query,
//            "username=dasdom&password=1234")
        XCTAssertEqual(
            mockURLSession.urlComponents?
                .percentEncodedQuery,
            "username=dasd%C3%B6m&password=%25%2634")
    }

    // 测试带 token 和参数的访问
    func test_Login_WhenSuccessful_CreatesToken() {
        // 带 token 的 json 数据
        let jsonData =
            "{\"token\": \"1234567890\"}"
                .data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: nil,
                                        error: nil)
        sut.session = mockURLSession
        let tokenExpectation = expectation(description: "Token")
        var caughtToken: Token? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, _)  in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken?.id, "1234567890")
        }
    }
}

extension APIClientTests {
    // 模拟URL缓存
    class MockURLSession: SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        // url组件对象
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url,
                                 resolvingAgainstBaseURL: true)
        }
        
        // 初始化方法
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data,
                                urlResponse: urlResponse,
                                error: error)
        }
        
        // 数据任务方法
        func dataTask(
            with url: URL,
            completionHandler: @escaping
            (Data?, URLResponse?, Error?) -> Void)
            -> URLSessionDataTask {
                self.url = url
                print(url)
                dataTask.completionHandler = completionHandler
                // 返回数据任务
                return dataTask
                //return URLSession.shared.dataTask(with: url)
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        typealias CompletionHandler = (Data?, URLResponse?, Error?)
            -> Void
        var completionHandler: CompletionHandler?
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        override func resume() {
            DispatchQueue.main.async() {
                self.completionHandler?(self.data,
                                        self.urlResponse,
                                        self.responseError)
            }
        }
    }
}
```

- 控制台  
```
Test Suite 'Selected tests' started at 2019-09-28 21:45:53.907
Test Suite 'ToDoTests.xctest' started at 2019-09-28 21:45:53.910
Test Suite 'APIClientTests' started at 2019-09-28 21:45:53.911
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedHost]' started.
https://awesometodos.com/login?username=dasdom&password=1234
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedHost]' passed (0.138 seconds).
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedPath]' started.
https://awesometodos.com/login?username=dasdom&password=1234
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedPath]' passed (0.002 seconds).
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedQuery]' started.
https://awesometodos.com/login?username=dasd%C3%B6m&password=%25%2634
Test Case '-[ToDoTests.APIClientTests test_Login_UsesExpectedQuery]' passed (0.005 seconds).
Test Case '-[ToDoTests.APIClientTests test_Login_WhenSuccessful_CreatesToken]' started.
https://awesometodos.com/login?username=Foo&password=Bar
Test Case '-[ToDoTests.APIClientTests test_Login_WhenSuccessful_CreatesToken]' passed (0.015 seconds).
Test Suite 'APIClientTests' passed at 2019-09-28 21:45:54.077.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.160 (0.166) seconds
Test Suite 'ToDoTests.xctest' passed at 2019-09-28 21:45:54.079.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.160 (0.169) seconds
Test Suite 'Selected tests' passed at 2019-09-28 21:45:54.080.
	 Executed 4 tests, with 0 failures (0 unexpected) in 0.160 (0.173) seconds
```