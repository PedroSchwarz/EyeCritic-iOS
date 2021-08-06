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
    
    var id: String {
        displayTitle
    }
}
