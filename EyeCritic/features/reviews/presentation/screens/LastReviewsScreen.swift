//
//  LastReviewsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import SwiftUI

struct LastReviewsScreen: View {
    @StateObject private var viewModel = AppModules.container.resolve(ReviewsViewModel.self)!
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                    case .initial:
                        ReviewsLoading()
                    case .loading:
                        ReviewsLoading()
                    case .success(let reviews):
                        ReviewsList(reviews: reviews, hasRefresh: true, onRefresh: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.viewModel.getLastReviews()
                            }
                        })
                    case .failure(let error):
                        ReviewsError(error: error)
                }
            }
            .navigationTitle("Latest Reviews")
        }
        .onAppear {
            self.viewModel.getLastReviews()
        }
    }
}

struct LastReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LastReviewsScreen()
    }
}
