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
    
    var dateStringUpdate: String
    var timeString: String
    var timeStringUpdate: String
    var timeZone: Int
    
    
    var detail: String
    var url: String
    var updated: TimeInterval
//    var felt: Int?
    
    init?(dictionary: JSON) {
        guard let properties = dictionary["properties"] as? JSON else { return nil }
        guard let mag = properties["mag"] as? Double else { return nil }
        guard let location = properties["title"] as? String else { return nil }
        guard let time = properties["time"] as? TimeInterval else { return nil }
        guard let place = properties["place"] as? String else { return nil }
        guard let url = properties["url"] as? String else { return nil }
        guard let detail = properties["detail"] as? String else { return nil }
        guard let updated = properties["updated"] as? TimeInterval else { return nil }
        guard let timeZone = properties["tz"] as? Int else { return nil }
//        guard let felt = properties["felt"] as? Int else { return }
        
        let splitString = place.components(separatedBy: "of")
        self.place = (splitString.first ?? "") + "OF"
        self.location = splitString.last ?? ""
        self.mag = mag
        self.time = time
        self.timeZone = timeZone
        self.url = url
        self.detail = detail
        self.updated = updated
//        self.felt = felt
        
        //MARK: Time
        let fomatterTime = DateFormatter()
        let fomatterDate = DateFormatter()
        let date = Date(timeIntervalSince1970: time/1000)
        let update = Date(timeIntervalSince1970: updated/1000)
        fomatterTime.timeStyle = .short
        fomatterDate.dateStyle = .medium
        fomatterTime.timeZone = TimeZone(secondsFromGMT: timeZone)
        fomatterTime.timeZone = TimeZone(abbreviation: "UTC")
        fomatterTime.locale = Locale(identifier: "en")
        fomatterDate.locale = Locale(identifier: "en")
        dateString = fomatterDate.string(from: date)
        timeString = fomatterTime.string(from: date)
        dateStringUpdate = fomatterDate.string(from: update)
        timeStringUpdate = fomatterTime.string(from: update)
        
        
        
        
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
//
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
