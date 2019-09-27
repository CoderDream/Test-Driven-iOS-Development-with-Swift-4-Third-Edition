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
        
        let query = "username=\(username.percentEncoded)&password=\(password.percentEncoded)"
        guard let url = URL(string:
            "https://awesometodos.com/login?\(query)") else {
                fatalError()
        }
        
//        session.dataTask(with: url) { (data, response, error) in
//        }
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let dict = try! JSONSerialization.jsonObject(
                with: data,
                options: []) as? [String:String]
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



protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping
        (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
    
}

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
