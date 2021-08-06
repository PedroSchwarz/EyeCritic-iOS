//
//  ReviewModelTest.swift
//  EyeCriticTests
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import XCTest
@testable import EyeCritic

class ReviewModelTest: XCTestCase {
    var reviewWithImage: Review!
    var reviewWithoutImage: Review!
    
    override func setUp() {
        self.reviewWithImage = Review(
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
        
        self.reviewWithoutImage = Review(
            displayTitle: "Title 1",
            rating: "4",
            byLine: "line 1",
            headline: "headline 1",
            summary: "Summary 1",
            publicationDate: "00/00/0000",
            imageUrl: "",
            link: "https://",
            favorite: false
        )
    }
    
    func testShouldConvertReviewModelToReviewWithMedia() {
        let reviewModel = ReviewModel(
            display_title: "Title 1",
            mpaa_rating: "4",
            byline: "line 1",
            headline: "headline 1",
            summary_short: "Summary 1",
            publication_date: "00/00/0000",
            multimedia: Multimedia(src: "https://"),
            link: Link(url: "https://")
        )
        
        let actualReview = reviewModel.toReview()
        
        XCTAssertEqual(actualReview, self.reviewWithImage)
    }
    
    func testShouldConvertReviewModelToReviewWithoutMedia() {
        let reviewModel = ReviewModel(
            display_title: "Title 1",
            mpaa_rating: "4",
            byline: "line 1",
            headline: "headline 1",
            summary_short: "Summary 1",
            publication_date: "00/00/0000",
            multimedia: nil,
            link: Link(url: "https://")
        )
        
        let actualReview = reviewModel.toReview()
        
        XCTAssertEqual(actualReview, self.reviewWithoutImage)
    }
}
