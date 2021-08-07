//
//  ReviewsRepositoryImplTest.swift
//  EyeCriticTests
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import XCTest
import Combine
@testable import EyeCritic

class ReviewsRepositoryImplTest: XCTestCase {
    var mockNetworkInfo: NetworkInfo!
    var mockRemoteDataSource: ReviewsRemoteDataSource!
    var mockLocalDataSource: ReviewsLocalDataSource!
    var repository: ReviewsRepositoryImpl!
    
    var remoteReviews: [Review]!
    var localReviews: [Review]!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        self.mockNetworkInfo = MockNetworkInfo()
        self.mockRemoteDataSource = MockReviewsRemoteDataSource()
        self.mockLocalDataSource = MockReviewsLocalDataSource()
        self.repository = ReviewsRepositoryImpl(
            network: self.mockNetworkInfo,
            remote: self.mockRemoteDataSource,
            local: self.mockLocalDataSource
        )
        
        self.remoteReviews = [
            ReviewModel(
                display_title: "Title 1",
                mpaa_rating: "4",
                byline: "line 1",
                headline: "headline 1",
                summary_short: "Summary 1",
                publication_date: "00/00/0000",
                multimedia: nil,
                link: Link(url: "https://")
            ).toReview()
        ]
        self.localReviews = [
            ReviewModel(
                display_title: "Title 2",
                mpaa_rating: "4",
                byline: "line 2",
                headline: "headline 2",
                summary_short: "Summary 2",
                publication_date: "00/00/0000",
                multimedia: nil,
                link: Link(url: "https://")
            ).toReview()
        ]
        self.cancellables = []
    }
    
    func testShouldReturnRemoteDataWhenConnected() {
        var reviews: [Review]?
        var error: Failure?
        
        let res = self.repository.getLastReviews()
        res.sink { completion in
            switch completion {
                case.finished:
                    break
                case .failure(let e):
                    error = e
            }
        } receiveValue: { value in
            reviews = value
        }
        .store(in: &cancellables)
        
        XCTAssertNil(error)
        XCTAssertEqual(reviews, self.remoteReviews)
    }
    
    func testShouldReturnLocalDataWhenNotConnected() {
        var reviews: [Review]?
        var error: Failure?
        
        let res = self.repository.getLastReviews()
        res.sink { completion in
            switch completion {
                case.finished:
                    break
                case .failure(let e):
                    error = e
            }
        } receiveValue: { value in
            reviews = value
        }
        .store(in: &cancellables)
        
        XCTAssertNil(error)
        XCTAssertEqual(reviews, self.localReviews)
    }
    
    func testShouldReturnServerFailureFromRemoteDataSource() {
        var reviews: [Review]?
        var error: Failure?
        
        let res = self.repository.getLastReviews()
        res.sink { completion in
            switch completion {
                case.finished:
                    break
                case .failure(let e):
                    error = e
            }
        } receiveValue: { value in
            reviews = value
        }
        .store(in: &cancellables)
        
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .server)
        XCTAssertNil(reviews)
    }
    
    func testShouldReturnServerFailureFromLocalDataSource() {
        var reviews: [Review]?
        var error: Failure?
        
        let res = self.repository.getLastReviews()
        res.sink { completion in
            switch completion {
                case.finished:
                    break
                case .failure(let e):
                    error = e
            }
        } receiveValue: { value in
            reviews = value
        }
        .store(in: &cancellables)
        
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .cache)
        XCTAssertNil(reviews)
    }
}

struct MockNetworkInfo: NetworkInfo {
    func isConnected() -> Bool {
        return false
    }
}

struct MockReviewsRemoteDataSource: ReviewsRemoteDataSource {
    func getLastReview() -> AnyPublisher<ApiResult, Failure> {
//        return Result.Publisher(
//            ApiResult(results:
//                [
//                    ReviewModel(
//                        display_title: "Title 1",
//                        mpaa_rating: "4",
//                        byline: "line 1",
//                        headline: "headline 1",
//                        summary_short: "Summary 1",
//                        publication_date: "00/00/0000",
//                        multimedia: nil,
//                        link: Link(url: "https://")
//                    )
//                ]
//            )
//        )
//        .eraseToAnyPublisher()
        return Result.Publisher(Failure(type: .server))
            .eraseToAnyPublisher()
    }
}

struct MockReviewsLocalDataSource: ReviewsLocalDataSource {
    func getCachedReview() -> AnyPublisher<[ReviewModel], Failure> {
//        return Result.Publisher(
//            [
//                ReviewModel(
//                    display_title: "Title 2",
//                    mpaa_rating: "4",
//                    byline: "line 2",
//                    headline: "headline 2",
//                    summary_short: "Summary 2",
//                    publication_date: "00/00/0000",
//                    multimedia: nil,
//                    link: Link(url: "https://")
//                )
//            ]
//        )
//        .eraseToAnyPublisher()
        return Result.Publisher(Failure(type: .cache))
            .eraseToAnyPublisher()
    }
    
    func cacheReviews(reviews: [ReviewModel]) {
        
    }
}
