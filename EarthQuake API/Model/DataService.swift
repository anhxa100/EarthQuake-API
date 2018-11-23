//
//  DataService.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/6/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = Dictionary<AnyHashable, Any>

class DataServices {
//    static let shared: DataServices = DataServices()
    
    
    static func fetchData(with urlString: String, completion: @escaping ([QuakeInfo]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respond, error) in
            if let dataRespond = data, error == nil {
                do {
                    guard let jsonResponse = try JSONSerialization.jsonObject(with: dataRespond, options: []) as? JSON else {
                        return
                    }
                    var quakeInfos: [QuakeInfo] = []
                    
                    let quakeInfosJSON = jsonResponse["features"] as? [JSON] ?? []
                    for itemJSON in quakeInfosJSON {
                        if let quakeInfo = QuakeInfo(dictionary: itemJSON) {
                            quakeInfos.append(quakeInfo)
                        }
                    }
                   
                    DispatchQueue.main.async {
                        completion(quakeInfos)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    
    
//    func getDataByNotification(with urlString: String) {
//        guard let url = URL(string: urlString) else { return}
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, respond, error) in
//            if let dataRespond = data, error == nil {
//                do {
//                    guard let jsonResponse = try JSONSerialization.jsonObject(with: dataRespond, options: []) as? JSON else {
//                        return
//                    }
//                    let quake = Quake(dictionary: jsonResponse)
//                    self.QuakeInfos = quake.QuakeInfos
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: Notification.Name(rawValue: "dataFetched"), object: nil)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }).resume()
//
//    }
}

