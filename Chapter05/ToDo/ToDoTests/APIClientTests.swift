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

    func test_Login_WhenSuccessful_CreatesToken() {
        let jsonData =
            "{\"token\": \"1234567890\"}"
                .data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: nil,
                                        error: nil)
        sut.session = mockURLSession
        let tokenExpectation = expectation(description: "Token")
        var caughtToken: Token? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { token, _
            in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken?.id, "1234567890")
        }
    }
}

extension APIClientTests {
    class MockURLSession: SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url,
                                 resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data,
                                urlResponse: urlResponse,
                                error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping
            (Data?, URLResponse?, Error?) -> Void)
            -> URLSessionDataTask {
                self.url = url
                print(url)
                dataTask.completionHandler = completionHandler
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
