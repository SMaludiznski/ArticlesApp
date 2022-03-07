//
//  Date+Extensions.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import Foundation

extension String {
    mutating func articleDateFormatter() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let newDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "d MMM, yyyy"
            return dateFormatter.string(from: newDate)
        } else {
            return nil
        }
    }
}
