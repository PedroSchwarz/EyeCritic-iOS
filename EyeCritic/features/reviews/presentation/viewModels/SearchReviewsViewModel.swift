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

    @Published private(set) var state: SearchReviewsState = .initial
    @Published var title: String = ""
    @Published private(set) var isValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: SearchReviews) {
        self.useCase = useCase
        
        isTitleValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
    
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
    
    private var isTitleValidPublisher: AnyPublisher<Bool, Never> {
        $title
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count > 0
            }
            .eraseToAnyPublisher()
    }
}
