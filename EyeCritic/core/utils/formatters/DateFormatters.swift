//
//  DateFormatters.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import Foundation

struct DateFormatters {
    static var localDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    static var fromStringFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
