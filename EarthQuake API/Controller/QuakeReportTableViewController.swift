//
//  QuakeReportTableViewController.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/6/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import UIKit

class QuakeReportTableViewController: UITableViewController {
    
    var quakeInfos: [QuakeInfo] = []
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        tableView.addSubview(refresh)
        refresh.attributedTitle = NSAttributedString(string : "Pull to refresh")// add Tittle for pull icon
        refresh.addTarget(self, action: #selector(refeshAPI), for: .valueChanged) //Adding a Target and Action
        refresh.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        tableView.rowHeight = 80
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let quakeUrlString = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"
        //        DataServices.shared.getDataByNotification(with: quakeUrlString)
        DataServices.fetchData(with: quakeUrlString, completion: { quake in
            //            quake.QuakeInfos.forEach({ (QuakeInfo) in
            //                print(QuakeInfo.mag, QuakeInfo.place, QuakeInfo.time)
            //            })
            self.quakeInfos = quake
            self.tableView.reloadData()
        })
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: Notification.Name(rawValue: "dataFetched"), object: nil)
    }
    
    
    @objc func refeshAPI() {
        refresh.beginRefreshing()
        tableView.reloadData()
        refresh.endRefreshing() //End of refesh
    }
    
    
    //    @objc func getData() {
    //        QuakeInfos = DataServices.shared.QuakeInfos
    //        tableView.reloadData()
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quakeInfos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.magLabel.text = String(quakeInfos[indexPath.row].mag)
        cell.distanceLabel.text = quakeInfos[indexPath.row].place.uppercased()
        cell.locationLabel.text? = quakeInfos[indexPath.row].location
        cell.timeLabel.text = quakeInfos[indexPath.row].timeString
        cell.dateLabel.text = quakeInfos[indexPath.row].dateString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: push - pop
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuakeDetailViewController") as? QuakeDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.myURLRequest = quakeInfos[indexPath.row].url
        vc?.detailAPI = quakeInfos[indexPath.row].detail

    }
   
    
    
    
}

