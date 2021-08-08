//
//  ReviewsRepositoryImpl.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine
import Network

struct ReviewsRepositoryImpl: ReviewsRepository {
    var network: NetworkInfo
    var remote: ReviewsRemoteDataSource
    var local: ReviewsLocalDataSource
    
    func getLastReviews() -> AnyPublisher<[Review], Failure> {
        if network.isConnected() {
            return remote.getLastReview()
                .handleEvents(receiveOutput: { result in
                    local.cacheReviews(reviews: result.results)
                })
                .map({ result in
                    result.results.map { $0.toReview() }
                })
                .eraseToAnyPublisher()
        } else {
            return local.getCachedReview()
                .map({ result in
                    result.map { $0.toReview() }
                })
                .eraseToAnyPublisher()
        }
    }
}
