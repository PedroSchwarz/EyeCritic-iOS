//
//  MovieModel.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation

struct ReviewModel: Codable {
    var display_title: String
    var mpaa_rating: String
    var byline: String
    var headline: String
    var summary_short: String
    var publication_date: String
    var multimedia: Multimedia?
    var link: Link
    
    func toReview() -> Review {
        Review(
            displayTitle: self.display_title,
            rating: self.mpaa_rating,
            byLine: self.byline,
            headline: self.headline,
            summary: self.summary_short,
            publicationDate: self.publication_date,
            imageUrl: self.multimedia?.src ?? "",
            link: self.link.url,
            favorite: false
        )
    }
}

struct Multimedia: Codable {
    var src: String
}

struct Link: Codable {
    var url: String
}
