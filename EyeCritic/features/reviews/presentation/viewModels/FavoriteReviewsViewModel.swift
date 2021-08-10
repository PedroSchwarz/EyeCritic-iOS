//
//  FavoriteReviewsViewModel.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import Foundation
import SwiftUI
import Combine

enum FavoriteReviewsState {
    case initial
    case loading
    case failure(error: String)
    case success(value: [Review])
}

class FavoriteReviewsViewModel: ObservableObject {
    var useCase: GetFavoriteReviews
    
    init(useCase: GetFavoriteReviews) {
        self.useCase = useCase
    }
    
    @Published private(set) var state: ReviewsState = .initial
    private var cancellables = Set<AnyCancellable>()
    
    func getFavoriteReviews() {
        self.state = .loading
        
        self.useCase.execute()
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let e):
                        self.state = .failure(error: self.mapFailureToMessage(failure: e))
                        break
                }
            } receiveValue: { value in
                self.state = .success(value: value)
            }
            .store(in: &cancellables)
    }
    
    func mapFailureToMessage(failure: Failure) -> String {
        switch failure.type {
            case .server:
                return "Error with the server"
            case .cache :
                return "Error with device data"
        }
    }
}
