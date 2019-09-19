//
//  ItemListViewController.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        // Do any additional setup after loading the view.
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }

}
