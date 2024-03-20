//
//  Date+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/7/24.
//

import Foundation

extension Date {
        
    // New Date Formatter for standard formats
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
    
}
