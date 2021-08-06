//
//  GetLastReviewsTest.swift
//  EyeCriticTests
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import XCTest
import Combine
@testable import EyeCritic

class GetLastReviewsTest: XCTestCase {
    var mockSuccessReviewsRepository: ReviewsRepository!
    var mockFailureReviewsRepository: ReviewsRepository!
    var useCase: GetLastReviews!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        self.mockSuccessReviewsRepository = MockSuccessReviewsRepository()
        self.mockFailureReviewsRepository = MockFailureReviewsRepository()
        self.cancellables = []
    }
    
    override func tearDown() {
        self.mockSuccessReviewsRepository = nil
        self.mockFailureReviewsRepository = nil
    }

    func testShouldGetDataSuccessfulyWhenCallingRepository() {
        self.useCase = GetLastReviews(repository: self.mockSuccessReviewsRepository)
        var reviews: [Review]?
        var error: Error?
        let expectation = self.expectation(description: "String")
        
        let res = self.useCase.execute()
        
        res.sink { completion in
            switch completion {
                case .finished:
                    break
                case .failure(let e):
                    error = e
            }
            expectation.fulfill()
        } receiveValue: { value in
            reviews = value
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        XCTAssertNil(error)
        XCTAssertEqual(reviews, [Review(
            displayTitle: "Title 1",
            rating: "4",
            byLine: "line 1",
            headline: "headline 1",
            summary: "Summary 1",
            publicationDate: "00/00/0000",
            imageUrl: "https://",
            link: "https://",
            favorite: false
        )])
    }
    
    func testShouldGetErrorWhenCallingRepository() {
        self.useCase = GetLastReviews(repository: self.mockFailureReviewsRepository)
        var review: [Review]?
        var error: Failure?
        let expectation = self.expectation(description: "Failure")
        
        let res = self.useCase.execute()
        
        res.sink { completion in
            switch completion {
                case .finished:
                    break
                case .failure(let e):
                    error = e
            }
            expectation.fulfill()
        } receiveValue: { value in
            review = value
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .server)
        XCTAssertNil(review)
    }
}

class MockSuccessReviewsRepository: ReviewsRepository {
    func getLastReviews() -> AnyPublisher<[Review], Failure> {
        return Result.Publisher([Review(
                    displayTitle: "Title 1",
                    rating: "4",
                    byLine: "line 1",
                    headline: "headline 1",
                    summary: "Summary 1",
                    publicationDate: "00/00/0000",
                    imageUrl: "https://",
                    link: "https://",
                    favorite: false
                )]
        )
        .eraseToAnyPublisher()
    }
}

class MockFailureReviewsRepository: ReviewsRepository {
    func getLastReviews() -> AnyPublisher<[Review], Failure> {
        return Result.Publisher(Failure(type: .server))
            .eraseToAnyPublisher()
    }
}
