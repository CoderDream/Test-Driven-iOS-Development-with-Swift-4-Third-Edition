//
//  ItemListViewController.swift
//  ToDo
//
//  Created by dasdom on 25.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate & ItemManagerSettable )!
    let itemManager = ItemManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider.itemManager = itemManager
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        //        present(InputViewController(),
        //                animated: true,
        //                completion: nil)
        
        if let nextViewController =
            storyboard?.instantiateViewController(
                withIdentifier: "InputViewController")
                as? InputViewController {
            nextViewController.itemManager = itemManager
            present(nextViewController, animated: true, completion: nil)
        }
    }
}
