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
        return itemManager?.toDoCount ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(
        in tableView: UITableView) -> Int {
        return 2
    }
}
