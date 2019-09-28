//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by CoderDream on 2019/9/27.
//  Copyright © 2019 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo

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
