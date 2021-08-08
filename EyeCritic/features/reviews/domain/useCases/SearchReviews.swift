//
//  SearchReviews.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import Foundation
import Combine

struct SearchReviews {
    var repository: ReviewsRepository
    
    func execute(for title: String) -> AnyPublisher<[Review], Failure> {
        return repository.searchReviews(title: title)
    }
}
