//
//  ReviewDetailsViewModel.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

enum ReviewDetailsState {
    case idle
    case failure
    case success
}

class ReviewDetailsViewModel: ObservableObject {
    var toggleUseCase: ToggleReviewFavorite
    var favoriteStatusUseCase: GetReviewFavoriteStatus
    
    init(toggleUseCase: ToggleReviewFavorite, favoriteStatusUseCase: GetReviewFavoriteStatus) {
        self.toggleUseCase = toggleUseCase
        self.favoriteStatusUseCase = favoriteStatusUseCase
    }
        
    @Published private(set) var image: Data?
    @Published private(set) var favorite: Bool = false
    @Published private(set) var state: ReviewDetailsState = .idle
    private var cancellables = Set<AnyCancellable>()
    
    func getProductImage(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            AF.request(url).response(queue: .main) { data in
                switch data.result {
                    case .success(let data):
                        self.image = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func toggleReviewFavorite(review: Review) {
        self.toggleUseCase.execute(for: review)
            .sink { completion in
                switch completion {
                case .failure(_):
                        self.state = .failure
                        break
                    case .finished:
                        break
                }
            } receiveValue: { _ in
                self.state = .success
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .idle
        }
    }
    
    func getReviewFavoriteStatus(review: Review) {
        self.favoriteStatusUseCase.execute(review: review)
            .sink { completion in
                switch completion {
                case .failure(_):
                        break
                    case .finished:
                        break
                }
            } receiveValue: { value in
                self.favorite = value
            }
            .store(in: &cancellables)
    }
}
