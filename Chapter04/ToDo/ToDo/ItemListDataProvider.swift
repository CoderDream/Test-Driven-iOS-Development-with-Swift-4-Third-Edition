//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/18.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

enum Section: Int {
    case toDo
    case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {        
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        let numberOfRows: Int
        switch itemSection {
        case .toDo:
            numberOfRows = itemManager.toDoCount
        case .done:
            numberOfRows = itemManager.doneCount
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ItemCell",
            for: indexPath) as! ItemCell    
        
        cell.configCell(with: ToDoItem(title: ""))
        //print(cell)
        return cell
    }
    
    func numberOfSections(
        in tableView: UITableView) -> Int {
        return 2
    }
}
