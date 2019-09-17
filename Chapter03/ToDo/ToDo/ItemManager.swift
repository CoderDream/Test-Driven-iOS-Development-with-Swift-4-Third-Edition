//
//  ItemManager.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation

class ItemManager {
//    var toDoCount = 0
//    var doneCount = 0
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    // 新增todo项目
    func add(_ item: ToDoItem) {
        //toDoCount += 1
        toDoItems.append(item)
    }
    
    // 根据序号查找待办项目
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    // 完成项目
    func checkItem(at index: Int) {
        //toDoCount -= 1
        //doneCount += 1
        // _ = toDoItems.remove(at: index)
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        //return ToDoItem(title: "")
        return doneItems[index]
    }
}
