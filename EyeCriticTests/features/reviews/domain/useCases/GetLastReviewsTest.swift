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
    var useCase: GetReviews!
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
        self.useCase = GetReviews(repository: self.mockSuccessReviewsRepository)
        var string: String?
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
            string = value
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        XCTAssertNil(error)
        XCTAssertEqual(string, "String")
    }
    
    func testShouldGetErrorWhenCallingRepository() {
        self.useCase = GetReviews(repository: self.mockFailureReviewsRepository)
        var string: String?
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
            string = value
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .server)
        XCTAssertNil(string)
    }
}

class MockSuccessReviewsRepository: ReviewsRepository {
    func getLastReviews() -> AnyPublisher<String, Failure> {
        return Result.Publisher("String")
            .eraseToAnyPublisher()
    }
}

class MockFailureReviewsRepository: ReviewsRepository {
    func getLastReviews() -> AnyPublisher<String, Failure> {
        return Result.Publisher(Failure(type: .server))
            .eraseToAnyPublisher()
    }
}
