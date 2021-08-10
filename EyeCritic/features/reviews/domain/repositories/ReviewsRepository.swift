//
//  ReviewsRepository.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine

protocol ReviewsRepository {
    func getLastReviews() -> AnyPublisher<[Review], Failure>
    
    func searchReviews(title: String) -> AnyPublisher<[Review], Failure>
    
    func toggleReviewFavorite(review: Review) -> AnyPublisher<Void, Failure>
    
    func getFavoriteReviews() -> AnyPublisher<[Review], Failure>
    
    func getReviewFavoriteStatus(review: Review) -> AnyPublisher<Bool, Failure>
}
