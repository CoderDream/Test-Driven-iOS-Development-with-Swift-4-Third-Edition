//
//  ViewController.swift
//  FirstDemo
//
//  Created by CoderDream on 2019/4/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
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
    
//    func numberOfVowels(in string: String) -> Int {
//        let vowels: [Character] = ["a", "e", "i", "o", "u",
//                                   "A", "E", "I", "O", "U"]
//        // 'characters' is deprecated: Please use String or Substring directly
//        //console.log(string.reduce(0))
//        print(string.reduce(0))
//        return string.reduce(0) {
//            $0 + (vowels.contains($1) ? 1 : 0)
//        }
//    }
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
}

