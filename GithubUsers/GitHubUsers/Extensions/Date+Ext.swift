//
//  Date+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/7/24.
//

import Foundation

extension Date {
    
    // Convert date Date into a formatted MMM yyyy date String
//    func convertToMonthYearFormat() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM yyyy"
//        
//        return dateFormatter.string(from: self)
//    }
    
    // New Date Formatter for standard formats
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
    
}
