//
//  GetReview.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine

struct GetReviews {
    var repository: ReviewsRepository
    
    func execute() -> AnyPublisher<String, Failure> {
        return repository.getLastReviews()
    }
}
