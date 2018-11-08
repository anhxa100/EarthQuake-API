//
//  DataService.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/6/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import Foundation
import UIKit

class Quake {
    var mag: Double = 6.5
    var distance: String = ""
    var location: String = ""
    var timeInterval: TimeInterval = Date().timeIntervalSince1970
    var mediumDateString: String = ""
    var shortDateString: String = ""
    
    
    init( distance: String, location: String) {
        self.distance = distance
        self.location = location
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja")
        dateFormatter.dateStyle = .long
        self.mediumDateString = dateFormatter.string(from: Date(timeIntervalSince1970: self.timeInterval))
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        self.shortDateString = dateFormatter.string(from: Date(timeIntervalSince1970: self.timeInterval))
        
    }
    
}

let url: URL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson")!

typealias DICT = Dictionary<AnyHashable, Any>

class DataQuake: NSObject, UITableViewDataSource {
    
    var data:[Quake] =
        [
            //        Quake(distance: "27 SSE OF", location: "Sary-Tash, Kyrgyzstan"),
            //        Quake(distance: "26 SSE OF", location: "Namatanai, Papua New Guinea")
    ]

    
    
    let tash = URLSession.shared.dataTask(with: url) { (data, respond, error) in
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        guard data != nil else {return}
        
        }


    //MARK: Request API
//    private func makeDataTaskRequest(request: URLRequest, completedBlock: @escaping (Quake) -> Void ) {
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            guard data != nil else { return }
//
//            do {
//                let model = JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data!)
//                DispatchQueue.main.async {
//                    completedBlock(model)
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }





    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.magLabel.text = String(data[indexPath.row].mag)
        cell.distanceLabel.text = data[indexPath.row].distance
        cell.locationLabel.text = data[indexPath.row].location
        cell.dateLabel.text = data[indexPath.row].mediumDateString
        cell.timeLabel.text = data[indexPath.row].shortDateString
        
        return cell
    }

}

