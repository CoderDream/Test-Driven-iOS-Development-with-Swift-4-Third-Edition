//
//  ToDoItem.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation

struct ToDoItem {
    let title: String
    let itemDescription: String?
    
    init(title: String,
         itemDescription: String? = nil) {
        self.title = title
        self.itemDescription = itemDescription
    }
}
