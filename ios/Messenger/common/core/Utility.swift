//
//  Utility.swift
//  Messenger
//
//  Created by Arnab Kar on 12/29/24.
//

import Foundation

func formattedDate(from epochSeconds: TimeInterval, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
    // Convert epoch seconds to Date
    let date = Date(timeIntervalSince1970: epochSeconds)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.string(from: date)
}

/***
 Usage: epochFromCustomDate(dateString: "19 Oct 2016 10:30 AM")
 */
func epochFromCustomDate(dateString: String, dateFormat: String = "dd MMM yyyy hh:mm a") -> TimeInterval? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    if let date = dateFormatter.date(from: dateString) {
        return date.timeIntervalSince1970
    } else {
        return nil
    }
}
