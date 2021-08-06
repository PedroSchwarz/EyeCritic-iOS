//
//  ReviewsRepository.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine

protocol ReviewsRepository {
    func getLastReviews() -> AnyPublisher<String, Failure>
}
