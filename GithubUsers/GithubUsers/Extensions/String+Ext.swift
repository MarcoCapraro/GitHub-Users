//
//  String+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/7/24.
//

import Foundation

extension String {
    
    // Convert date String into a Date
    func converToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        // Takes string of the dateFormat and returns it as a Date
        return dateFormatter.date(from: self)
    }
    
    // Combines the String and Date extensions to go from String -> Date -> Formatted String
    func convertToDisplayFormat() -> String {
        guard let date = self.converToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
