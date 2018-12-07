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
        
        let magNum = quakeInfos[indexPath.row].mag
        
        //MARK: set color for mag label
        if magNum > 0 && magNum < 2 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0x4A7BA7)
        }
        if magNum >= 2 && magNum < 3 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0x04B4B3)
        }
        if magNum >= 3 && magNum < 4 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0x10CAC9)
        }
        if magNum >= 4 && magNum < 5 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xF5A623)
        }
        if magNum >= 5 && magNum < 6 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xFF7D50)
        }
        if magNum >= 6 && magNum < 7 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xFC6644)
        }
        if magNum >= 7 && magNum < 8 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xE75F40)
        }
        if magNum >= 8 && magNum < 9 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xE13A20)
        }
        if magNum >= 9 && magNum < 10 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xD93218)
        }
        if magNum > 10 {
            cell.magLabel.backgroundColor = UIColor.colorFormHex(hex: 0xC03823)
        }
        
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

