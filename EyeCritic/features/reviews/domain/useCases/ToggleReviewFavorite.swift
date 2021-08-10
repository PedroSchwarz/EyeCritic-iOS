//
//  ToggleReviewFavorite.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import Foundation
import Combine

struct ToggleReviewFavorite {
    var repository: ReviewsRepository
    
    func execute(for review: Review) -> AnyPublisher<Void, Failure> {
        return repository.toggleReviewFavorite(review: review)
    }
}
