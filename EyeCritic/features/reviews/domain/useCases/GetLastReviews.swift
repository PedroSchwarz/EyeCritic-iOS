//
//  GetReview.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine

struct GetLastReviews {
    var repository: ReviewsRepository
    
    func execute() -> AnyPublisher<[Review], Failure> {
        return repository.getLastReviews()
    }
}
