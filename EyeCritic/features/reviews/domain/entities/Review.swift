//
//  Review.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation

struct Review: Identifiable, Equatable {
    var displayTitle: String
    var rating: String
    var byLine: String
    var headline: String
    var summary: String
    var publicationDate: String
    var imageUrl: String
    var link: String
    var favorite: Bool
    
    // Id for ForEach view
    var id: String {
        displayTitle
    }
    
    // Formatted publication date
    var formattedDate: String {
        if let date = DateFormatters.fromStringFormat.date(from: self.publicationDate) {
            let formatter = DateFormatters.localDateFormat
            return formatter.string(from: date)
        } else {
            return "N/A"
        }
    }
}
