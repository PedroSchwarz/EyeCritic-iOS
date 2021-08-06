//
//  Data.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation

var mockReview = Review(
    displayTitle: "Title 1",
    rating: "4",
    byLine: "line 1",
    headline: "headline 1",
    summary: "Summary 1",
    publicationDate: "00/00/0000",
    imageUrl: "https://",
    link: "https://",
    favorite: false
)

var mockReviewModel = ReviewModel(
    display_title: "Title 1",
    mpaa_rating: "4",
    byline: "line 1",
    headline: "headline 1",
    summary_short: "Summary 1",
    publication_date: "00/00/0000",
    multimedia: nil,
    link: Link(url: "https://")
)
