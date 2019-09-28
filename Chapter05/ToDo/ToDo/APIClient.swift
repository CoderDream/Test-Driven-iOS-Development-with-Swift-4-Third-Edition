//
//  APIClient.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/27.
//  Copyright © 2019 dasdom. All rights reserved.
//

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
