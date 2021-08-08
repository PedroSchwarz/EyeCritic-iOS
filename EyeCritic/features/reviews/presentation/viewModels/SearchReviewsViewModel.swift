//
//  SearchReviewsViewModel.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import Foundation
import SwiftUI
import Combine

enum SearchReviewsState {
    case initial
    case loading
    case failure(error: String)
    case success(value: [Review])
}

class SearchReviewsViewModel: ObservableObject {
    var useCase: SearchReviews
    
    init(useCase: SearchReviews) {
        self.useCase = useCase
    }
    
    @Published var title: String = ""
    @Published private(set) var state: SearchReviewsState = .initial
    private var cancellables = Set<AnyCancellable>()
    
    func clearTitleInput() {
        self.title = ""
    }
    
    func searchReviews() {
        self.state = .loading
        
        self.useCase.execute(for: self.title)
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
