//
//  GetFavoriteReviews.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import Foundation
import Combine

struct GetFavoriteReviews {
    var repository: ReviewsRepository
    
    func execute() -> AnyPublisher<[Review], Failure> {
        return repository.getFavoriteReviews()
    }
}
