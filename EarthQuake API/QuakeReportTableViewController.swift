//
//  QuakeReportTableViewController.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/6/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import UIKit

class QuakeReportTableViewController: UITableViewController {

    let data = DataQuake()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = data
        
    }

    
}
