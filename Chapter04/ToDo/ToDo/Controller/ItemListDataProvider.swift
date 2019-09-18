//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/18.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        //return 0
        //return itemManager?.toDoCount ?? 0
//        let numberOfRows: Int
//        switch section {
//        case 0:
//            numberOfRows = itemManager?.toDoCount ?? 0
//        case 1:
//            //numberOfRows = 1
//            numberOfRows = itemManager?.doneCount ?? 0
//        default:
//            numberOfRows = 0
//        }
//        return numberOfRows
        
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
        //return UITableViewCell()
        return ItemCell()
    }
    
    func numberOfSections(
        in tableView: UITableView) -> Int {
        return 2
    }
}

enum Section: Int {
    case toDo
    case done
}
