//
//  EarthQuake.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/12/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import Foundation

class QuakeInfo {
    var mag: Double
    var place: String
    var location: String
    var time: TimeInterval
    var dateString: String
    var timeString: String
    var url: String
    var detail: String
    
    init?(dictionary: JSON) {
        guard let properties = dictionary["properties"] as? JSON else { return nil }
        guard let mag = properties["mag"] as? Double else { return nil }
        guard let location = properties["title"] as? String else { return nil }
        guard let time = properties["time"] as? TimeInterval else { return nil }
        guard let place = properties["place"] as? String else { return nil }
        guard let url = properties["url"] as? String else { return nil }
        guard let detail = properties["detail"] as? String else { return nil }
        
        let splitString = place.components(separatedBy: "of")
        self.place = (splitString.first ?? "") + "OF"
        self.location = splitString.last ?? ""
        self.mag = mag
        self.time = time
        self.url = url
        self.detail = detail
        
        let fomatterTime = DateFormatter()
        let fomatterDate = DateFormatter()
        fomatterTime.timeStyle = .short
        fomatterDate.dateStyle = .medium
        let date = Date(timeIntervalSince1970: time/1000)
        dateString = fomatterDate.string(from: date)
        timeString = fomatterTime.string(from: date)
    }
}
//
//class Quake {
//    var features: [Feature] = []
//    init?(dictionary: JSON) {
//        guard let features = dictionary["features"] as? [JSON] else { return nil }
//        for feature in features {
//            if let dataFeature = Feature(dictionary: feature) {
//                self.features.append(dataFeature)
//            }
//        }
//    }
//}

//class Feature {
//    var mag: Double
//    var place: String
//    var time: TimeInterval
//
//    init?(dictionary: JSON) {
//        let properties = dictionary["properties"] as? JSON ?? [:]
//        let mag = properties["mag"] as? Double ?? -999
//        let place = properties["place"] as? String ?? "-999"
//        let time = properties["time"] as? TimeInterval ?? -999
//
//        self.mag = mag
//        self.place = place
//        self.time = time
//    }
//}
