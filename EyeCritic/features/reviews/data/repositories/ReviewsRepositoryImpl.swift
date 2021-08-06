//
//  ReviewsRepositoryImpl.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine

struct ReviewRepositoryImpl: ReviewsRepository {
    func getLastReviews() -> AnyPublisher<[Review], Failure> {
        return Result.Publisher(
            [
                mockReview
            ]
        )
            .eraseToAnyPublisher()
    }
}
